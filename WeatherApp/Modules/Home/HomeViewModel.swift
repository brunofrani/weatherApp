//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import UIKit
import Combine
import CoreData

final class HomeViewModel: NSObject {
  
  private let dependecies: AppDependencies
  @Published var state: ViewModelState = .initial
  
  init(dependencies: AppDependencies) {
    self.dependecies = dependencies
  }
  
  fileprivate lazy var fetchedResultsController: NSFetchedResultsController<ManagedCity> = {
    let fetchRequest = ManagedCity.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "woeid", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dependecies.persistenceService.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()
  
  
  func getLocalCities()  {
    state = .loading
    do {
      try fetchedResultsController.performFetch()
    } catch( let error ){
      state = .error(value: error)
    }
  }
}

extension HomeViewModel: NSFetchedResultsControllerDelegate {
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    let snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
    let managedCities: [ManagedCity] =  snapshot.itemIdentifiers.compactMap { objectID in
      guard let managedCity = try? dependecies.persistenceService.persistentContainer.viewContext.existingObject(with: objectID) as? ManagedCity else {
        return nil
      }
      return managedCity
    }
    let cities = managedCities.map {
      City(lattLong: $0.lattlong, locationType: $0.locationType, title: $0.title, weoid: Int($0.woeid))
    }
    state = .data(value: cities)
  }
}


