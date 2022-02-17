//
//  SearchPresenter.swift
//  TestProject
//
//  Created by Muhammad Taifoor Saleem on 25/01/2022.
//

import UIKit

class SearchPresenter: ProtocolViewToPresenterSearch, ProtocolInteractorToPresenterSearch
{
  //MARK: DATA MEMBERS
  
  private var view: ProtocolPresenterToViewSearch?
  private var interactor: ProtocolPresenterToInteractorSearch?
  private var router: ProtocolPresenterToRouterSearch?
  
  var results: [Results]?
  
  //END OF DATA MEMBERS
  
  init(view: ProtocolPresenterToViewSearch?, interactor: ProtocolPresenterToInteractorSearch?, router: ProtocolPresenterToRouterSearch?)
  {
    //Setting Up Data Members
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
  func initInteractor() {
    interactor?.setPresenter(presenter: self)
  }
  func setupCell(cell: ResultCell, index: Int) -> ResultCell {
    cell.setupCell(listKey: results?[index].listKey ?? Constants.newListKey, text: results?[index].path ?? Constants.emptyString)
    return cell
  }
  
  func getRowCount() -> Int {
    return results?.count ?? 1
  }
  
  func fetchData(query: String) {
    interactor?.fetchResults(query: query, completion: { results in
      self.results = results
    })
  }
  
  func pushToOpenList(listKey: Int, listName: String) {
    router?.pushToOpenList(view: self.view, with: listName, listKey: listKey, editable: false)
  }
  
}
