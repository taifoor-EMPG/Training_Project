//
//  Utilities.swift
//  To-Do-VIPER
//
//  Created by Muhammad Taifoor Saleem on 14/01/2022.
//

import UIKit

struct Utilities
{
  private static let errorList = [
                                  1: ["Duplicate List", "There already exists a list with this name\n Try Something Else?", "Dismiss"],
                                  2: ["Empty Entry", "You did not type anything\n Try Something Else?", "Dismiss"],
                                  3: ["Data Not Received", "Something Went Wrong", "Dismiss"],
                                  4: ["Data Unable to be Fetched", "Something went wrong", "Close"],
                                  5: ["Failed to Create a Group", "Something went wrong", "Close"],
                                  6: ["Duplicate Group", "There already exists a group with this name\n Try Something Else?", "Dismiss"]
  ]
  
  private static let defaultError = ["Something Went Wrong", "Error Not Found", "Dismiss"]
  
  //Error 0:  Error Reference Not Found
  //          The error referenced in Code does not exist in database
  //      title:   Something Went Wrong
  //      message: Error Not Found
  //      button: Dismiss
  
  //Error 1:  Duplicate List Created
  //          Two Lists with same name cannot be created
  //      title:   Error 01: Duplicate List
  //      message: There already exists a List with this name\n Try Something Else?
  //      button: Dismiss
  
  //Error 2:  Text Box was empty when DONE was pressed
  //      title:   Empty Entry
  //      message: You did not type anything\n Try Something Else?
  //      button: Dismiss
  
  
  
  //Standard Error Alert Generator
  //Wrapper Function
  static func popAnError(_ _self:UIViewController, _ errorCode:Int)
  {
    guard let error = errorList[errorCode] else
    {
      popAnError(_self, defaultError)
      return
    }
    
    popAnError(_self, error)
    return
  }
  
  static func newList() -> String
  {
    return Constants.newListTitle
  }
  
  static func convertToString(_ numerics: Int) -> String
  {
    if numerics > 0
    {
      return String(numerics)
    }
    return ""
  }
  
  static func getErrorCodes() -> [Int]
  {
    return Array(errorList.keys)
  }
}


extension Utilities
{
  //Core Implementation
  private static func popAnError(_ _self:UIViewController, _ error:[String])
  {
    let alert = UIAlertController(title: error[0], message: error[1], preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: error[2], style: UIAlertAction.Style.default, handler: nil))
    _self.present(alert, animated: true, completion: nil)
  }
}
