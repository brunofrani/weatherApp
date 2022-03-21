//
//  SearchCityViewModel.swift
//  WeatherApp
//
//  Created by Bruno Frani on 14.3.22.
//

import Foundation
import CoreData

final class SearchCityViewModel {
  
  private let dependecies: AppDependencies
  @Published var state: ViewModelState = .initial
  @Published var saved: Bool?
  
  init(dependencies: AppDependencies) {
    self.dependecies = dependencies
  }
  
  func getCitiesContaining(_ cityName: String) {
    state = .loading
    dependecies.networkClient.searchCity(name: cityName) { [weak self] result in
      switch result {
        
      case .success(let cities):
        if cities.isEmpty {
          self?.state = .empty
        } else {
          self?.state = .data(value: cities)
        }
      case .failure(let error):
        self?.state = .error(value: error)
      }
    }
  }
  
  func saveCity(_ city: City) {
    
    do {
      try dependecies.persistenceService.saveCity(city)
      self.saved = true
    } catch {
      self.saved = false
    }
  }
}

