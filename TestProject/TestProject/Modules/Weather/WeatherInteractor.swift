//
//  WeatherInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//

import UIKit

class WeatherInteractor: ProtocolPresenterToInteractorWeather
{
  //MARK: DATA MEMBERS
  
  private weak var presenter: ProtocolInteractorToPresenterWeather?
  private var source: WeatherDataRepositoryProtocol?
  
  //END OF DATA MEMBERS
  
  init(source : WeatherDataRepositoryProtocol?)
  {
    guard source != nil else
    {
      //RAISE SOME ERROR HERE
      return
    }
    self.source = source
  }
  
  func setPresenter(presenter: ProtocolInteractorToPresenterWeather?)
  {
    guard presenter != nil else
    {
      //RAISE SOME ERROR HERE
      return
    }
    self.presenter = presenter
  }
  
  func getLocationInformation(latitude: Double, longitude: Double) {
    //Set Location for checking
    //let lat = 40.730610
    //let long = -73.935242
    
    source?.getLocationInfo(lat: latitude, lon: longitude, completion: { result in
      self.presenter?.setLocationData(locationData: result)
      if let city = result.local_names[Constants.WeatherLanguages.english] {
        self.getWeatherInformation(city: city.lowercased(), metric: units.metric)
      }
    })
  }
  
  func getWeatherInformation(city: String, metric: units) {
    source?.getWeatherInfo(city: city, metric: units.metric, completion: { result in
      self.presenter?.setWeatherData(weatherData: result)
      self.presenter?.setView()
    })
  }
}
