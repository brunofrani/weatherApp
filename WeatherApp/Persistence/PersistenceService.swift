//
//  PersistenceService.swift
//  WeatherApp
//
//  Created by Bruno Frani on 15.3.22.
//

import Foundation
import CoreData
import SwiftUI

class PersistenceService {
  
  let persistentContainer: NSPersistentContainer
  
  init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
    self.persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
  }
  
  
  func saveCity(_ city: City) throws {
    
    guard let woeid = city.woeid else {
      throw AppError(title: "Error in persistence", description: "The city to be stored doesn't has a valid woeid")
    }
    
    let woiedPredicate = NSPredicate(format: "woeid == %d", woeid)
    
    let fetchRequest = ManagedCity.fetchRequest()
    fetchRequest.predicate = woiedPredicate
    if let object = try? persistentContainer.viewContext.fetch(fetchRequest).first {
      object.woeid = Int64(city.woeid ?? 0)
      object.title = city.title
      object.lattlong = city.lattLong
      object.locationType = city.locationType
    } else {
      
      let managedCity = ManagedCity(context: persistentContainer.viewContext)
      
      managedCity.woeid = Int64(city.woeid ?? 0)
      managedCity.title = city.title
      managedCity.lattlong = city.lattLong
      managedCity.locationType = city.locationType
    }
    try persistentContainer.viewContext.save()
  }
  
  
  func saveForecast(_ weather: ForecastModel) throws{
    guard let woeid = weather.woeid,
          let consolidatedWeather = weather.consolidatedWeather,
          let sources = weather.sources,
          let parent = weather.parent   else {
      throw AppError(title: "Error in persistence", description: "The city to be stored doesn't has a valid woeid")
    }
    
    let woiedPredicate = NSPredicate(format: "woeid == %d", woeid)
    
    let fetchRequest = ManagedForecast.fetchRequest()
    fetchRequest.predicate = woiedPredicate
    if let object = try? persistentContainer.viewContext.fetch(fetchRequest).first {
      object.locationType = weather.locationType
      object.lattLong = weather.lattLong
      object.sunRise = weather.sunRise
      object.sunSet = weather.sunSet
      object.time = weather.time
      object.timezone = weather.timezone
      object.timezoneName = weather.timezoneName
      object.title = weather.title
      
      let managedConsolidated = consolidatedWeather.map {  consolidated -> ManagedConsolidatedWeather in
        return parseToManagedConsolidatedWeather(consolidated: consolidated, context: persistentContainer.viewContext)
      }
      object.consolidatedWeather = Set(managedConsolidated)
      
      let managedSources = sources.map { source -> ManagedSource in
        return parseToManagedSource(source: source, context: persistentContainer.viewContext)
      }
      object.source = Set(managedSources)
      
      let managedParent = parseToManagedParent(parent: parent, context: persistentContainer.viewContext)
      object.parent = managedParent
      
    } else {
      
      let object = ManagedForecast(context: persistentContainer.viewContext)
      object.locationType = weather.locationType
      object.lattLong = weather.lattLong
      object.sunRise = weather.sunRise
      object.sunSet = weather.sunSet
      object.time = weather.time
      object.timezone = weather.timezone
      object.timezoneName = weather.timezoneName
      object.title = weather.title
      
      
      
      let managedConsolidated = consolidatedWeather.map {  consolidated -> ManagedConsolidatedWeather in
        return parseToManagedConsolidatedWeather(consolidated: consolidated, context: persistentContainer.viewContext)
      }
      object.consolidatedWeather = Set(managedConsolidated)
      
      let managedSources = sources.map { source -> ManagedSource in
        return parseToManagedSource(source: source, context: persistentContainer.viewContext)
      }
      object.source = Set(managedSources)
      
      let managedParent = parseToManagedParent(parent: parent, context: persistentContainer.viewContext)
      object.parent = managedParent
      
    }
    try persistentContainer.viewContext.save()
  }
  
}

extension PersistenceService {
  func parseToManagedConsolidatedWeather(consolidated: ConsolidatedWeather, context: NSManagedObjectContext) -> ManagedConsolidatedWeather {
    
    let managedConsolidatedWeather = ManagedConsolidatedWeather(context: context)
    managedConsolidatedWeather.airPresure = consolidated.airPressure ?? 0
    managedConsolidatedWeather.applicableData = consolidated.applicableDate
    managedConsolidatedWeather.created = consolidated.created
    managedConsolidatedWeather.humidity = consolidated.humidity ?? 0
    managedConsolidatedWeather.maxTemp = consolidated.maxTemp ?? 0
    managedConsolidatedWeather.minTemp = managedConsolidatedWeather.minTemp
    managedConsolidatedWeather.predictability = consolidated.predictability ?? 0
    managedConsolidatedWeather.theTemp = consolidated.theTemp ?? 0
    managedConsolidatedWeather.visibility = consolidated.visibility ?? 0
    managedConsolidatedWeather.weatherStateAbbr = consolidated.weatherStateAbbr
    managedConsolidatedWeather.weatherStateName = consolidated.weatherStateName
    managedConsolidatedWeather.windDirection = consolidated.windDirection ?? 0
    managedConsolidatedWeather.windDirectionCompass = consolidated.windDirectionCompass
    managedConsolidatedWeather.windSpeed = consolidated.windSpeed ?? 0
    return managedConsolidatedWeather
  }
  
  func parseToManagedSource(source: Source , context: NSManagedObjectContext) -> ManagedSource {
    
    let managedSource = ManagedSource(context: context)
    managedSource.title = source.title
    managedSource.url = source.url
    managedSource.crawlRate = Int64(source.crawlRate ?? 0)
    managedSource.slug = source.slug
    
    return managedSource
  }
  
  func parseToManagedParent(parent: Parent, context: NSManagedObjectContext) -> ManagedParent {
    let managedParent = ManagedParent(context: context)
    managedParent.lattLong = parent.lattLong
    managedParent.locationType = parent.locationType
    managedParent.title = parent.title
    managedParent.woeid = Int64(parent.woeid ?? 0)
    return managedParent
  }
}
