//
//  ConsolidatedWeather.swift
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ConsolidatedWeather : Codable, Hashable {
  
  let airPressure : Float?
  let applicableDate : String?
  let created : String?
  let humidity : Float?
  let id : Int?
  let maxTemp : Float?
  let minTemp : Float?
  let predictability : Float?
  let theTemp : Float?
  let visibility : Float?
  let weatherStateAbbr : String?
  let weatherStateName : String?
  let windDirection : Float?
  let windDirectionCompass : String?
  let windSpeed : Float?
  
  init(airPresure:Float?,
       applicableDate: String?,
       created: String?,
       humidity: Float?,
       id: Int?,
       maxTemp: Float?,
       minTemp: Float?,
       predictability: Float?,
       theTemp: Float?,
       visibility: Float?,
       weatherStateName: String?,
       weatherStateAbbr: String?,
       windDirection: Float?,
       windDirectionCompass: String,
       windSpeed: Float?) {
    
    self.airPressure = airPresure
    self.applicableDate = applicableDate
    self.created = created
    self.humidity = humidity
    self.id = id
    self.maxTemp = maxTemp
    self.minTemp = minTemp
    self.predictability = predictability
    self.theTemp = theTemp
    self.visibility = visibility
    self.weatherStateAbbr = weatherStateAbbr
    self.weatherStateName = weatherStateName
    self.windDirection = windDirection
    self.windDirectionCompass = windDirectionCompass
    self.windSpeed = windSpeed
  }
  
  enum CodingKeys: String, CodingKey {
    case airPressure = "air_pressure"
    case applicableDate = "applicable_date"
    case created = "created"
    case humidity = "humidity"
    case id = "id"
    case maxTemp = "max_temp"
    case minTemp = "min_temp"
    case predictability = "predictability"
    case theTemp = "the_temp"
    case visibility = "visibility"
    case weatherStateAbbr = "weather_state_abbr"
    case weatherStateName = "weather_state_name"
    case windDirection = "wind_direction"
    case windDirectionCompass = "wind_direction_compass"
    case windSpeed = "wind_speed"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    airPressure = try values.decodeIfPresent(Float.self, forKey: .airPressure)
    applicableDate = try values.decodeIfPresent(String.self, forKey: .applicableDate)
    created = try values.decodeIfPresent(String.self, forKey: .created)
    humidity = try values.decodeIfPresent(Float.self, forKey: .humidity)
    id = try values.decodeIfPresent(Int.self, forKey: .id)
    maxTemp = try values.decodeIfPresent(Float.self, forKey: .maxTemp)
    minTemp = try values.decodeIfPresent(Float.self, forKey: .minTemp)
    predictability = try values.decodeIfPresent(Float.self, forKey: .predictability)
    theTemp = try values.decodeIfPresent(Float.self, forKey: .theTemp)
    visibility = try values.decodeIfPresent(Float.self, forKey: .visibility)
    weatherStateAbbr = try values.decodeIfPresent(String.self, forKey: .weatherStateAbbr)
    weatherStateName = try values.decodeIfPresent(String.self, forKey: .weatherStateName)
    windDirection = try values.decodeIfPresent(Float.self, forKey: .windDirection)
    windDirectionCompass = try values.decodeIfPresent(String.self, forKey: .windDirectionCompass)
    windSpeed = try values.decodeIfPresent(Float.self, forKey: .windSpeed)
  }
  
  
}
