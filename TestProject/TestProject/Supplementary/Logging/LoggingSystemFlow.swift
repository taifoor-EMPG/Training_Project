//
//  LoggingSystemFlow.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 11/02/2022.
//

import Foundation

class LoggingSystemFlow
{
  //MARK: Data Members
  private static var underDevelopment:Bool = false
  //End Data Members
  
  static func enableDevelopmentMode(){
    underDevelopment = true
  }
  static func disableDevelopmentMode(){
    underDevelopment = false
  }
  static func printLog(_ text: Any){
    if underDevelopment == true
    {
      print(text)
    }
  }
}

