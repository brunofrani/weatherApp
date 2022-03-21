//
//  NetworkClient.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import Foundation
import Moya

class NetworkClient {
  
  let weatherProvider: MoyaProvider<WeatherService> = MoyaProvider<WeatherService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
}

extension NetworkClient {
  
  func getForecast(cityId: Int, date: String, completion: @escaping (Result<ForecastModel, MoyaError>) -> Void) {
    weatherProvider.request(.getForecast(cityId: cityId, date: date)) { result in
      switch result {
        
      case .success(let response):
        do {
          _ = try response.filterSuccessfulStatusCodes()
          let forecast = try JSONDecoder().decode(ForecastModel.self, from: response.data)
          completion(.success(forecast))
        } catch(let error) {
          print(error)
          completion(.failure(MoyaError.underlying(error, response)))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
    
  }
  
  func searchCity(name: String, completion: @escaping (Result<[City], MoyaError>) -> Void) {
    weatherProvider.request(.searchCity(name: name)) { result in
      switch result {
        
      case .success(let response):
        do {
          _ = try response.filterSuccessfulStatusCodes()
          let cities = try JSONDecoder().decode([City].self, from: response.data)
          completion(.success(cities))
        } catch(let error) {
          completion(.failure(MoyaError.underlying(error, response)))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func downloadImage(abbreviation: WeatherAbbreviation, completion: @escaping (Result<Void, MoyaError>) -> Void) {
    weatherProvider.request(.downloadImage(abbreviation: abbreviation)) { result in
      switch result {
      case .success(let response):
        do {
          _ = try response.filterSuccessfulStatusCodes()
          completion(.success(()))
        } catch(let error) {
          completion(.failure(MoyaError.underlying(error, response)))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func downloadAllImages(completion: @escaping (Result<Void, MoyaError>) -> Void) {
    
    for abbreviation in WeatherAbbreviation.allCases {
      downloadImage(abbreviation: abbreviation, completion: completion)
    }
  }
}
