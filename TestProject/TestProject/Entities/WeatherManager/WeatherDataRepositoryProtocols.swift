//
//  WeatherDataRepositoryProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//

import Foundation

protocol WeatherDataRepositoryProtocol
{
  func getLocationInfo(lat: Double, lon: Double, completion: @escaping (LocationData) -> Void)
  func getWeatherInfo(city: String, metric: units, completion: @escaping (WeatherData) -> Void)
}
