//
//  Weather.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//

import UIKit
import AVFoundation

class Weather: UIView, ProtocolPresenterToViewWeather{

  //MARK: Data Members
  private var presenter: (ProtocolViewToPresenterWeather & ProtocolInteractorToPresenterWeather)?
  
  private let language = Constants.WeatherLanguages.arabic
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var dataView: UIStackView!
  @IBOutlet weak var maxTemp: UILabel!
  @IBOutlet weak var minTemp: UILabel!
  @IBOutlet weak var feelsLike: UILabel!
  @IBOutlet weak var country: UILabel!
  @IBOutlet weak var city: UILabel!
  @IBOutlet weak var unit: UILabel!
  @IBOutlet weak var currentTemp: UILabel!
  @IBOutlet weak var symbol: UIImageView!
  
  
  @IBOutlet weak var degree1: UILabel!
  @IBOutlet weak var serperator1: UILabel!
  @IBOutlet weak var label1: UILabel!
  @IBOutlet weak var degree2: UILabel!
  @IBOutlet weak var label2: UILabel!
  @IBOutlet weak var seperator2: UILabel!
  @IBOutlet weak var degre2: UILabel!
  //END OF DATA MEMBERS
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  func setPresenter(_ presenter: (ProtocolViewToPresenterWeather & ProtocolInteractorToPresenterWeather)?){
      self.presenter = presenter
    presenter?.initWeatherInfo()
  }
  
  func getLanguage() -> String {
    return language
  }
  
  func setWeather(condition: String, currentTemp: Int, unit: String, city: String, country: String, feelsLike: Int, minTemp: Int, maxTemp: Int, videoName: String){
    
    var image = ""
    if condition.contains("wind")
    {
      image = "wind"
    }
    else if condition.contains("cloud")
    {
      image = "cloud.fill"
    }
    else if condition.contains("rain")
    {
      image = "cloud.rain.fill"
    }
    else if condition.contains("clear")
    {
      image = "sun.min.fill"
    }
    
    var color: UIColor
    if videoName.contains("Day")
    {
      color = UIColor(named: "Col_Black") ?? .systemRed
    }
    else
    {
      color = UIColor(named: "Col_White") ?? .systemRed
    }
    
    
    DispatchQueue.main.async {
      //Update UI on main thread

      self.symbol.image = UIImage(systemName: image)
      self.symbol.tintColor = color
      
      self.currentTemp.text = String(currentTemp)
      self.currentTemp.textColor = color
      
      self.unit.text = "C"
      self.unit.textColor = color
      
      self.city.text = city
      self.city.textColor = color
      
      self.country.text = country
      self.country.textColor = color
      
      self.feelsLike.text = String(feelsLike)
      self.feelsLike.textColor = color
      
      self.minTemp.text = String(minTemp)
      self.minTemp.textColor = color
      
      self.maxTemp.text = String(maxTemp)
      self.maxTemp.textColor = color
      
      
      self.degree1.textColor = color
      self.serperator1.textColor = color
      self.label1.textColor = color
      self.degree2.textColor = color
      self.label2.textColor = color
      self.seperator2.textColor = color
      self.degre2.textColor = color
      
      self.playVideo(videoName: videoName)
    }
  }
}

//MARK: Private Utility Functions
extension Weather
{
  private func commonInit()
  {
    Bundle.main.loadNibNamed("Weather", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
  
  private func playVideo(videoName: String)
  {
    guard let path = Bundle.main.path(forResource: videoName, ofType: Constants.WeatherVideos.filetype) else {
      return
    }
    
    let player = AVPlayer(url: URL(fileURLWithPath: path))
    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = self.frame
    playerLayer.videoGravity = .resizeAspectFill
    contentView.layer.addSublayer(playerLayer)
    player.play()
    contentView.bringSubviewToFront(dataView)
  }
}
