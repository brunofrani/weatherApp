//
//  ManagedForecast+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Bruno Frani on 16.3.22.
//
//

import Foundation
import CoreData


extension ManagedForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedForecast> {
        return NSFetchRequest<ManagedForecast>(entityName: "ManagedForecast")
    }

    @NSManaged public var lattLong: String?
    @NSManaged public var locationType: String?
    @NSManaged public var sunRise: String?
    @NSManaged public var sunSet: String?
    @NSManaged public var time: String?
    @NSManaged public var timezone: String?
    @NSManaged public var timezoneName: String?
    @NSManaged public var title: String?
    @NSManaged public var woeid: Int64
    @NSManaged public var consolidatedWeather: Set<ManagedConsolidatedWeather>?
    @NSManaged public var parent: ManagedParent?
    @NSManaged public var source: Set<ManagedSource>?
    @NSManaged public var city: ManagedCity?

}

// MARK: Generated accessors for consolidatedWeather
extension ManagedForecast {

    @objc(addConsolidatedWeatherObject:)
    @NSManaged public func addToConsolidatedWeather(_ value: ManagedConsolidatedWeather)

    @objc(removeConsolidatedWeatherObject:)
    @NSManaged public func removeFromConsolidatedWeather(_ value: ManagedConsolidatedWeather)

    @objc(addConsolidatedWeather:)
    @NSManaged public func addToConsolidatedWeather(_ values: NSSet)

    @objc(removeConsolidatedWeather:)
    @NSManaged public func removeFromConsolidatedWeather(_ values: NSSet)

}

extension ManagedForecast : Identifiable {

}
