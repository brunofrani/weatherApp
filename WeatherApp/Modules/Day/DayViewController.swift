//
//  DayViewController.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import UIKit
import Combine

class DayViewController: UITableViewController {
  
  private let weather: ConsolidatedWeather
  
  init(weather: ConsolidatedWeather) {
    self.weather = weather
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Weather for \( weather.applicableDate ?? "")"
    tableView.reloadData()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "default cell")
    var content = cell.defaultContentConfiguration()
    switch indexPath.row {
    case 0 :
      content.text = weather.weatherStateName ?? ""
      content.image = getImgeFromAbbeviation(weather.weatherStateAbbr ?? "")
      cell.contentConfiguration = content
    case 1 :
      content.text = "Humidity"
      content.secondaryText = "\(weather.humidity ?? 0)"
      cell.contentConfiguration = content
    case 2 :
      content.text = "Max Temperature"
      content.secondaryText = "\(weather.maxTemp ?? 0)"
      cell.contentConfiguration = content
    case 3 :
      content.text = "Min Temperature"
      content.secondaryText = "\(weather.minTemp ?? 0)"
      cell.contentConfiguration = content
    case 4 :
      content.text = "Predictability"
      content.secondaryText = "\(weather.predictability ?? 0)"
      cell.contentConfiguration = content
    case 5 :
      content.text = "Visibility"
      content.secondaryText = "\(weather.visibility ?? 0)"
      cell.contentConfiguration = content
    case 6 :
      content.text = "Wind Direction"
      content.secondaryText = "\(weather.windDirection ?? 0)"
      cell.contentConfiguration = content
    case 7 :
      content.text = "Wind Speed"
      content.secondaryText = "\(weather.windSpeed ?? 0)"
      cell.contentConfiguration = content
    default:
      break
    }
    return cell
  }
  
  func getImgeFromAbbeviation(_ abbr: String) -> UIImage? {
    do {
      let directory: URL = cacheDirectory
      var filePath: URL = directory.appendingPathComponent(abbr)
      filePath = filePath.appendingPathExtension("png")
      let imageData = try Data(contentsOf: filePath)
      let image = UIImage(data: imageData)
      return image
    } catch {
      return nil
    }
  }
}



