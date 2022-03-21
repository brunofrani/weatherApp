//
//  AppDependencies.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import Foundation
import Moya

protocol HasNetworkCient {
  var networkClient: NetworkClient { get set }
  var persistenceService: PersistenceService { get set }
}

struct AppDependencies: HasNetworkCient {
  var networkClient: NetworkClient
  var persistenceService: PersistenceService
}
