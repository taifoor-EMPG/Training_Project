//
//  SearchInteractor.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 25/01/2022.
//

import UIKit

class SearchInteractor: ProtocolPresenterToInteractorSearch
{
  //DATA MEMBERS
  
  private weak var presenter: ProtocolInteractorToPresenterSearch?
  private var source: ProtocolDataRepository?
  
  //END OF DATA MEMBERS
  
  init(source : ProtocolDataRepository)
  {
    self.source = source
  }
  
  func setPresenter(presenter: ProtocolInteractorToPresenterSearch)
  {
    self.presenter = presenter
  }
  
  func fetchResults(query: String, completion: @escaping ([Results]?) -> Void)
  {
    source?.searchQuery(query: query, completion: { results in
      completion(results)
    })
  }
  
}
