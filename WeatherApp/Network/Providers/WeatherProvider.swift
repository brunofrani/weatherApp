//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import Foundation
import Moya


enum WeatherService {
  case downloadImage(abbreviation: WeatherAbbreviation)
  case getForecast(cityId: Int, date: String)
  case searchCity(name: String)
}

extension WeatherService: TargetType {
  
  var baseURL: URL {
    return NetworkConstants.baseUrl
  }
  
  var path: String {
    switch self {
    case .downloadImage(abbreviation: let abbreviation):
      return "static/img/weather/png/64/\(abbreviation.rawValue).png"
    case .getForecast(cityId: let cityId, date: let date):
      return "api/location/\(cityId)/\(date)"
    case .searchCity:
      return "api/location/search/"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Task {
    switch self {
    case .downloadImage:
      return .downloadDestination(downloadDestination)
    case .getForecast:
      return .requestPlain
    case .searchCity(name: let name):
      return .requestParameters(parameters: ["query": name], encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
  
}


var cacheDirectory: URL {
  let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
  return urls[urls.endIndex - 1]
}

extension WeatherService {
  
  var localLocation: URL {
    switch self {
    case .downloadImage(let fileName):
      
      let directory: URL = cacheDirectory
      var filePath: URL = directory.appendingPathComponent(fileName.rawValue)
      filePath = filePath.appendingPathExtension("png")
      return filePath
    default:
      return cacheDirectory
    }
  }
  
  var downloadDestination: DownloadDestination {
    return { _, _ in return (self.localLocation, [.removePreviousFile, .createIntermediateDirectories]) }
  }
  
}
