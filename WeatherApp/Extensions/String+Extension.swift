//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Bruno Frani on 17.3.22.
//

import Foundation

extension String {
  
  func toDate(format: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.date(from: self)
  }
  
}
