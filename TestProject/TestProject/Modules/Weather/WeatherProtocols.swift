//
//  WeatherProtocols.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//
import UIKit

//MARK: - View Input
//To Pass information from Presenter to View
protocol ProtocolViewToPresenterWeather
{
  //Setting Up View
  func initInteractor()
  func initWeatherInfo()
}


//MARK: - View Output
//To Pass information from View to Presenter
protocol ProtocolPresenterToViewWeather: AnyObject
{
  //Get Language
  func getLanguage() -> String
  
  //Setting up Weather View
  func setWeather(condition: String, currentTemp: Int, unit: String, city: String, country: String, feelsLike: Int, minTemp: Int, maxTemp: Int, videoName: String)
}


//MARK: - Interactor Input
//Functions that are needed from Interactor are placed here
protocol ProtocolPresenterToInteractorWeather
{
  //Initializer Functions
  func setPresenter(presenter: ProtocolInteractorToPresenterWeather?)
  func getLocationInformation(latitude: Double, longitude: Double)
}

protocol ProtocolInteractorToPresenterWeather: AnyObject
{
  func setLocationData(locationData: LocationData)
  func setWeatherData(weatherData: WeatherData)
  func setView()
}

//MARK: - Router Protocol - All functionalities from Router come here
protocol ProtocolPresenterToRouterWeather
{
  static func createModule(parentView: ProtocolPresenterToViewPopulateList?) -> UIView?
}



