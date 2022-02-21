//
//  Results.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 11/02/2022.
//

import Foundation

struct Results
{
  var listKey: Int = Constants.newListKey
  var path: String = Constants.emptyString
}

struct LocationData: Decodable
{
  let name: String
  let local_names: [String: String]
  let country: String
  let state: String
}

struct WeatherData: Decodable
{
  let list: [LocalizedWeather]
}

struct LocalizedWeather: Decodable{
  let name: String
  let main: TempatureDetail

  let weather: [ConditionDetail]
}

struct TempatureDetail: Decodable
{
  let temp: Double
  let feels_like: Double
  let temp_min: Double
  let temp_max: Double
  let humidity: Int
}

struct ConditionDetail: Decodable
{
  let main: String
  let description: String
}
