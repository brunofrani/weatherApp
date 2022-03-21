//
//  CityModel.swift
//  WeatherApp
//
//  Created by Bruno Frani on 6.3.22.
//

import Foundation

struct City: Codable, Hashable {
  let lattLong : String?
  let locationType : String?
  let title : String?
  let woeid : Int?
  
  init(lattLong: String?, locationType: String?, title: String?, weoid: Int?){
    self.lattLong = lattLong
    self.locationType = locationType
    self.title = title
    self.woeid = weoid
  }
  
  enum CodingKeys: String, CodingKey {
    case lattLong = "latt_long"
    case locationType = "location_type"
    case title = "title"
    case woeid = "woeid"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    lattLong = try values.decodeIfPresent(String.self, forKey: .lattLong)
    locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
    title = try values.decodeIfPresent(String.self, forKey: .title)
    woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
  }
  
  
}
