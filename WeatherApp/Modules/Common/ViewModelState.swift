//
//  ViewModelState.swift
//  WeatherApp
//
//  Created by Bruno Frani on 14.3.22.
//

import Foundation

enum ViewModelState {
  case initial
  case loading
  case data(value: Any)
  case empty
  case error(value: Error)
}
