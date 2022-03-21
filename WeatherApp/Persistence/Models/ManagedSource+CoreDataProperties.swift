//
//  ManagedSource+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Bruno Frani on 16.3.22.
//
//

import Foundation
import CoreData


extension ManagedSource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedSource> {
        return NSFetchRequest<ManagedSource>(entityName: "ManagedSource")
    }

    @NSManaged public var crawlRate: Int64
    @NSManaged public var slug: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var forecast: ManagedForecast?

}

extension ManagedSource : Identifiable {

}
