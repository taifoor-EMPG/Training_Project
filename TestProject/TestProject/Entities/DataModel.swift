//
//  File.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation

class DataModel
{
    private var dataSource: ProtocolDataSource?
    
    init(_ parameter: ProtocolDataSource?)
    {
        if parameter != nil
        {
            dataSource = parameter
        }
    }
    
    
    
}
