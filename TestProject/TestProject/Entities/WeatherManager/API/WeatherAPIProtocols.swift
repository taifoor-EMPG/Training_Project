//
//  WeatherAPIProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//

import Foundation

protocol WeatherAPIProtocols
{
  func fetchWeather(city: String, metric: units, completion: @escaping (WeatherData?) -> Void)
  func fetchCity(latitude: Double, longitude: Double, completion: @escaping (LocationData?) -> Void)
}
