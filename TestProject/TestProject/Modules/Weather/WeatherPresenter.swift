//
//  WeatherPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//

import UIKit
import CoreLocation

class WeatherPresenter: NSObject, ProtocolViewToPresenterWeather, ProtocolInteractorToPresenterWeather {
  //MARK: DATA MEMBERS
  
  private var view: ProtocolPresenterToViewWeather?
  private var interactor: ProtocolPresenterToInteractorWeather?
  private var router: ProtocolPresenterToRouterWeather?
  
  let locationManager = CLLocationManager()
  
  private var locationData: LocationData?
  private var weatherData: WeatherData?
  
  //END OF DATA MEMBERS
  
  init(view: ProtocolPresenterToViewWeather?, interactor: ProtocolPresenterToInteractorWeather?, router: ProtocolPresenterToRouterWeather?)
  {
    //Setting Up Data Members
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
  func initInteractor() {
    interactor?.setPresenter(presenter: self)
  }
  
  func initWeatherInfo() {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
  
  func setLocationData(locationData: LocationData)
  {
    self.locationData = locationData
  }
  
  func setWeatherData(weatherData: WeatherData)
  {
    self.weatherData = weatherData
  }
}

//MARK: Location Related Functionalities
extension WeatherPresenter: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last
    {
      let lat = location.coordinate.latitude
      let lon = location.coordinate.longitude
      
      interactor?.getLocationInformation(latitude: lat, longitude: lon)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    LoggingSystemFlow.printLog("In WeatherPresenter >> func locationManager (didFailWithError) >> Error Occured")
  }
}

//Setting Up View
extension WeatherPresenter
{
  func setView() {
    //All Graphics Should be set here
    
    guard let verifiedLocationData = locationData else
    {
      return
    }
    
    guard let verfiedWeatherData = weatherData else
    {
      return
    }
    
    let currentTemp = verfiedWeatherData.list[0].main.temp
    let feelsLike = verfiedWeatherData.list[0].main.feels_like
    let min  = verfiedWeatherData.list[0].main.temp_min
    let max  = verfiedWeatherData.list[0].main.temp_max
    
    let city = verifiedLocationData.local_names[view?.getLanguage() ?? Constants.WeatherLanguages.english]
    let country = verifiedLocationData.country
    
    var videoLink = ""
    
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    
    if hour >= 5 && hour <= 17
    {
      videoLink = "_Day"
    }
    else
    {
      videoLink = "_Night"
    }
    
    var condition = verfiedWeatherData.list[0].weather[0].main
    condition = condition.lowercased()
    
    if condition.contains("wind")
    {
      videoLink = "Windy" + videoLink
    }
    else if condition.contains("cloud")
    {
      videoLink = "Cloudy" + videoLink
    }
    else if condition.contains("rain")
    {
      videoLink = "Rainy" + videoLink
    }
    else if condition.contains("clear")
    {
      videoLink = "Clear" + videoLink
    }
    
    view?.setWeather(condition: condition, currentTemp: Int(currentTemp), unit: units.metric.rawValue, city: city ?? Constants.emptyString, country: country, feelsLike: Int(feelsLike), minTemp: Int(min), maxTemp: Int(max), videoName: videoLink)
  }
}
