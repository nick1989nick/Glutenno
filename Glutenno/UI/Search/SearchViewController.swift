//
//  SearchViewController.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 08/02/2021.
//

import Foundation
import UIKit


protocol SearchFilterProtocol {
    
    func filterContentForSearchText(_ text: String)
}

class SearchViewController : BaseViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchFilterProtocol: SearchFilterProtocol? = nil
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        searchFilterProtocol?.filterContentForSearchText(searchBar.text!)
    }
}
