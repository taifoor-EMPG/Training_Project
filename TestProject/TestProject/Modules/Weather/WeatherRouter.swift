//
//  WeatherRouter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 18/02/2022.
//


import UIKit

class WeatherRouter: ProtocolPresenterToRouterWeather
{
  static func createModule(parentView: ProtocolPresenterToViewPopulateList?) -> UIView? {
    let view = Weather(frame: parentView?.getFrame() ?? CGRect())
    
    let source = WeatherDataRepository(pluging: WeatherAPI())
    
    let presenter: ProtocolViewToPresenterWeather & ProtocolInteractorToPresenterWeather = WeatherPresenter(view: view, interactor: WeatherInteractor(source: source), router: WeatherRouter())
    
    presenter.initInteractor()
    view.setPresenter(presenter)
    
    //Set Data Members Here
    
    return view
  }
}
