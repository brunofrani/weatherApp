//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Bruno Frani on 6.3.22.
//

//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ForecastModel : Codable, Hashable {
  
  let consolidatedWeather : [ConsolidatedWeather]?
  let lattLong : String?
  let locationType : String?
  let parent : Parent?
  let sources : [Source]?
  let sunRise : String?
  let sunSet : String?
  let time : String?
  let timezone : String?
  let timezoneName : String?
  let title : String?
  let woeid : Int?
  
  
  enum CodingKeys: String, CodingKey {
    case consolidatedWeather = "consolidated_weather"
    case lattLong = "latt_long"
    case locationType = "location_type"
    case parent
    case sources = "sources"
    case sunRise = "sun_rise"
    case sunSet = "sun_set"
    case time = "time"
    case timezone = "timezone"
    case timezoneName = "timezone_name"
    case title = "title"
    case woeid = "woeid"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    consolidatedWeather = try values.decodeIfPresent([ConsolidatedWeather].self, forKey: .consolidatedWeather)
    lattLong = try values.decodeIfPresent(String.self, forKey: .lattLong)
    locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
    parent = try Parent(from: decoder)
    sources = try values.decodeIfPresent([Source].self, forKey: .sources)
    sunRise = try values.decodeIfPresent(String.self, forKey: .sunRise)
    sunSet = try values.decodeIfPresent(String.self, forKey: .sunSet)
    time = try values.decodeIfPresent(String.self, forKey: .time)
    timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
    timezoneName = try values.decodeIfPresent(String.self, forKey: .timezoneName)
    title = try values.decodeIfPresent(String.self, forKey: .title)
    woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
  }
  
  
}
