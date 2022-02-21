//
//  WeatherAPI.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//

import Foundation

enum units: String {
  case standard = "standard"
  case metric = "metric"
  case imperial = "imperial"
}

class WeatherAPI: WeatherAPIProtocols
{
  //MARK: DATA MEMBER
  public static let shared = WeatherAPI()
  
  func fetchWeather(city: String, metric: units = units.metric, completion: @escaping (WeatherData?) -> Void)
  {
    let urlString = formURL(city: city, metric: metric)
    
    //1. Create a URL
    if let url = URL(string: urlString)
    {
      //2. Create URL Session
      let session = URLSession(configuration: .default)
      
      //3. Give the session a task
      let task = session.dataTask(with: url, completionHandler: { data, response, error in
        if error != nil{
          print(error!)
          return
        }
        
        if let safeData = data{
          let dataToReturn = self.parseJSONWeatherData(weatherData: safeData)
          //Data being transmitted here
          completion(dataToReturn)
        }
      })
      
      //4. Start the task
      task.resume()
    }
  }
  
  func fetchCity(latitude: Double, longitude: Double, completion: @escaping (LocationData?) -> Void)
  {
    let urlString = formURL(latitude: latitude, longitude: longitude)
    
    //1. Create a URL
    if let url = URL(string: urlString)
    {
      //2. Create URL Session
      let session = URLSession(configuration: .default)
      
      //3. Give the session a task
      let task = session.dataTask(with: url, completionHandler: { data, response, error in
        if error != nil{
          print(error!)
          return
        }
        
        if let safeData = data{
          let dataToReturn = self.parseJSONNameData(nameData: safeData)
          
          //Data being transmitted here
          completion(dataToReturn)
        }
      })
      
      //4. Start the task
      task.resume()
    }
  }
}


//MARK: Private Utitity Methods
extension WeatherAPI
{
  private func formURL(city: String, metric: units = units.metric) -> String
  {
    return Constants.API.WeatherCredentials.url + Constants.API.GeneralCredentials.apiIdentifier + Constants.API.GeneralCredentials.apiKey + "&" + Constants.API.WeatherCredentials.cityIdentifier + city.lowercased() + "&" + Constants.API.WeatherCredentials.unitIdentifier + metric.rawValue
  }
  
  private func formURL(latitude: Double, longitude: Double) -> String
  {
    let lat = String(latitude)
    let lon = String(longitude)
    
    return Constants.API.GeolocationCredentials.url + Constants.API.GeolocationCredentials.latitudeIdentifier + lat + "&" + Constants.API.GeolocationCredentials.longitudeIdentifier + lon + "&" + Constants.API.GeolocationCredentials.limitIdentifier + String(3) + "&" + Constants.API.GeneralCredentials.apiIdentifier + Constants.API.GeneralCredentials.apiKey
  }
  
  private func parseJSONNameData(nameData: Data) -> LocationData?
  {
    let decoder = JSONDecoder()
    do
    {
      let decodedResult = try decoder.decode([LocationData].self, from: nameData)
      return decodedResult[0]
    }
    catch
    {
      LoggingSystemFlow.printLog("In WeatherAPI >> func parseJSONNameData")
      return nil
    }
  }
  
  private func parseJSONWeatherData(weatherData: Data) -> WeatherData?
  {
    let decoder = JSONDecoder()
    do
    {
      let decodedResult = try decoder.decode(WeatherData.self, from: weatherData)
      return decodedResult
    }
    catch
    {
      LoggingSystemFlow.printLog("In WeatherAPI >> func parseJSONNameData")
      return nil
    }
  }
}
