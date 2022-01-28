//
//  File.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 28/01/2022.
//

import Foundation

class DataModel
{
    private var dataSource: ProtocolEntity?
    
    init(_ parameter: ProtocolEntity?)
    {
        if parameter != nil
        {
            dataSource = parameter
        }
    }
}
