//
//  WeatherDataRepository.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//

import Foundation

class WeatherDataRepository: WeatherDataRepositoryProtocol
{
  //MARK: DATA MEMEBERS
  private let plugin: WeatherAPIProtocols?
  
  init(pluging: WeatherAPIProtocols? = WeatherAPI.shared)
  {
    self.plugin = pluging
  }
  
  func getLocationInfo(lat: Double, lon: Double, completion: @escaping (LocationData) -> Void) {
    plugin?.fetchCity(latitude: lat, longitude: lon, completion: { result in
      
      guard let confirmedResult = result else {
        return
      }
      completion(confirmedResult)
    })
  }
  
  func getWeatherInfo(city: String, metric: units = units.metric, completion: @escaping (WeatherData) -> Void) {
    plugin?.fetchWeather(city: city, metric: units.metric, completion: { result in
      guard let confirmedResult = result else {
        return
      }
      completion(confirmedResult)
    })
  }
}
