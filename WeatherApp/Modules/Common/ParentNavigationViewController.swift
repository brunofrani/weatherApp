//
//  ParentNavigationViewController.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import UIKit
import Moya

class ParentNavigationViewController: UINavigationController {
  
  private lazy var dependencies: AppDependencies = {
    let networkClient = NetworkClient()
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let persistenceService = PersistenceService(persistentContainer:  persistentContainer)
    let dependencies = AppDependencies(networkClient: networkClient, persistenceService: persistenceService)
    return dependencies
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addInitialCities()
    let viewController = HomeViewController(dependecies: dependencies)
    viewControllers = [viewController]
  }
  
  func addInitialCities() {
    do {
      let sofia = City(lattLong: "42.697079,23.324551", locationType: "City", title: "Sofia", weoid: 839722)
      let tokyo = City(lattLong: "35.670479,139.740921", locationType: "City", title: "Tokyo", weoid: 1118370)
      let ny = City(lattLong:  "40.71455,-74.007118", locationType: "City", title:   "New York", weoid:  2459115)
      let initialCities = [sofia, tokyo, ny]
      for city in initialCities {
        try dependencies.persistenceService.saveCity(city)
      }
    } catch {
      print(error)
    }
  }
  
}
