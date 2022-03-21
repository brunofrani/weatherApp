//
//  SourceModel.swift
//  WeatherApp
//
//  Created by Bruno Frani on 6.3.22.
//
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Source : Codable, Hashable {

  let crawlRate : Int?
  let slug : String?
  let title : String?
  let url : String?


  enum CodingKeys: String, CodingKey {
    case crawlRate = "crawl_rate"
    case slug = "slug"
    case title = "title"
    case url = "url"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    crawlRate = try values.decodeIfPresent(Int.self, forKey: .crawlRate)
    slug = try values.decodeIfPresent(String.self, forKey: .slug)
    title = try values.decodeIfPresent(String.self, forKey: .title)
    url = try values.decodeIfPresent(String.self, forKey: .url)
  }


}
