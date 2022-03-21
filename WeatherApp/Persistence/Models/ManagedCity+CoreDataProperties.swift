//
//  ManagedCity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Bruno Frani on 16.3.22.
//
//

import Foundation
import CoreData


extension ManagedCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCity> {
        return NSFetchRequest<ManagedCity>(entityName: "ManagedCity")
    }

    @NSManaged public var lattlong: String?
    @NSManaged public var locationType: String?
    @NSManaged public var title: String?
    @NSManaged public var woeid: Int64
    @NSManaged public var forecast: ManagedForecast?

}

extension ManagedCity : Identifiable {

}
