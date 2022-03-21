//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import UIKit
import Combine
import CoreData

final class CityViewModel: NSObject {
  
  private let dependecies: AppDependencies
  var consolidatedWeather: [ConsolidatedWeather] = [ConsolidatedWeather]()
  private let woeid: Int
  @Published var state: ViewModelState = .initial
  
  init(dependencies: AppDependencies, woeid: Int) {
    self.dependecies = dependencies
    self.woeid = woeid
  }
  
  fileprivate lazy var fetchedResultsController: NSFetchedResultsController<ManagedForecast> = {
    let fetchRequest = ManagedForecast.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "woeid", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dependecies.persistenceService.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()
  
  func downloadImages() {
    dependecies.networkClient.downloadAllImages { [weak self] result in
      switch result {
      case .success:
        break
      case .failure(let error):
        self?.state = .error(value: error)
      }
    }
  }
  
  func getForecast() {
    state = .loading
    do {
      try fetchedResultsController.performFetch()
      
      dependecies.networkClient.getForecast(cityId: woeid, date: "") { [weak self] result in
        switch result {
          
        case .success(let forecast):
          do {
            try self?.dependecies.persistenceService.saveForecast(forecast)
          } catch(let error) {
            self?.state = .error(value: error)
          }
          
        case .failure(let error):
          self?.state = .error(value: error)
        }
      }
      
    } catch(let error) {
      state = .error(value: error)
    }
  }
  
}

extension CityViewModel: NSFetchedResultsControllerDelegate {
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    
    let snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
    let managedForecast: [ManagedForecast] =  snapshot.itemIdentifiers.compactMap { objectID in
      guard let managedForecast = try? dependecies.persistenceService.persistentContainer.viewContext.existingObject(with: objectID) as? ManagedForecast else {
        return nil
      }
      return managedForecast
    }
    
    guard let forecast = managedForecast.first, let weather = forecast.consolidatedWeather else {
      state = .error(value: AppError(title: "Persistence Error", description: "Can,t get the managed object"))
      return }
    
    let consolidatedWeather =  weather.map { consolidated -> ConsolidatedWeather in
      
      ConsolidatedWeather(
        airPresure: consolidated.airPresure,
        applicableDate: consolidated.applicableData,
        created: consolidated.created,
        humidity: consolidated.humidity,
        id: Int(consolidated.id),
        maxTemp: consolidated.maxTemp,
        minTemp: consolidated.minTemp,
        predictability: consolidated.predictability,
        theTemp: consolidated.theTemp,
        visibility: consolidated.visibility,
        weatherStateName: consolidated.weatherStateName,
        weatherStateAbbr: consolidated.weatherStateAbbr,
        windDirection: consolidated.windDirection,
        windDirectionCompass: consolidated.windDirectionCompass ?? "",
        windSpeed: consolidated.windSpeed)
      
    }.sorted { con1, con2 in
      guard let date1 = con1.applicableDate?.toDate(format: "yyyy-MM-dd"), let date2 = con2.applicableDate?.toDate(format: "yyyy-MM-dd") else { return false }
      return date1 < date2
    }
    self.consolidatedWeather = consolidatedWeather
    state = .data(value: consolidatedWeather)
  }
}
