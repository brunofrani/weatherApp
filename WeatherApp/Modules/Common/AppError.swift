//
//  AppError.swift
//  WeatherApp
//
//  Created by Bruno Frani on 16.3.22.
//

import Foundation

struct AppError: Error {
  let title: String
  let description: String
}
