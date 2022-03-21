//
//  ManagedConsolidatedWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Bruno Frani on 16.3.22.
//
//

import Foundation
import CoreData


extension ManagedConsolidatedWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedConsolidatedWeather> {
        return NSFetchRequest<ManagedConsolidatedWeather>(entityName: "ManagedConsolidatedWeather")
    }

    @NSManaged public var airPresure: Float
    @NSManaged public var applicableData: String?
    @NSManaged public var created: String?
    @NSManaged public var humidity: Float
    @NSManaged public var id: Int64
    @NSManaged public var maxTemp: Float
    @NSManaged public var minTemp: Float
    @NSManaged public var predictability: Float
    @NSManaged public var theTemp: Float
    @NSManaged public var visibility: Float
    @NSManaged public var weatherStateAbbr: String?
    @NSManaged public var weatherStateName: String?
    @NSManaged public var windDirection: Float
    @NSManaged public var windDirectionCompass: String?
    @NSManaged public var windSpeed: Float
    @NSManaged public var forecast: ManagedForecast?

}

extension ManagedConsolidatedWeather : Identifiable {

}
