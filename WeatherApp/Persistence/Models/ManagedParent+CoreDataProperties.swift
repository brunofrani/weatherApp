//
//  ManagedParent+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Bruno Frani on 16.3.22.
//
//

import Foundation
import CoreData


extension ManagedParent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedParent> {
        return NSFetchRequest<ManagedParent>(entityName: "ManagedParent")
    }

    @NSManaged public var lattLong: String?
    @NSManaged public var locationType: String?
    @NSManaged public var title: String?
    @NSManaged public var woeid: Int64
    @NSManaged public var forecast: ManagedForecast?

}

extension ManagedParent : Identifiable {

}
