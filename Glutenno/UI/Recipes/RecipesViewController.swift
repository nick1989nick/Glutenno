//
//  RecipesViewController.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 03/02/2021.
//

import Foundation
import UIKit
import RxSwift

protocol RecipesView {
    func showItems(recipes: [Category: [Recipe]])
    func showCategories(category: [Category])
    func showError(message: String)
}

class RecipiesViewController: SearchViewController, RecipesView, SearchFilterProtocol {
   
    @IBOutlet var tableView: UITableView!
    
    var items = [Category]()
    var recipes: [Category: [Recipe]] = [:] {
        didSet {
            tableView.reloadData()
        }
    }
    var filtered = [Recipe]()
    var showSearchList: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    var viewModel: RecipesViewModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RecipesViewModel(apiService: apiService, recipesView: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        searchFilterProtocol = self
          
        viewModel?.getData()
    }
    
    func showItems(recipes: [Category : [Recipe]]) {
        self.recipes = recipes
    }
    
    func showCategories(category: [Category]) {
        self.items = category
    }
    
    func showError(message: String) {
        
    }
    
    func filterContentForSearchText(_ text: String) {
        filtered = []
        if text.isEmpty {
            filtered = []
            showSearchList = false
        } else {
            for (_, recipes) in recipes {
                for recipe in recipes {
                    if recipe.name.lowercased().contains(text.lowercased())  {
                        filtered.append(recipe)
                    }
                }
            }
            showSearchList = true
        }
    }

}

extension RecipiesViewController: UITableViewDelegate {
    
}

extension RecipiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showSearchList == true {
            return filtered.count
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if showSearchList == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchRecipesCell") as! SearchRecipesCell
            let filter = filtered[indexPath.row]
            cell.name.text = filter.name
            cell.mainImage.downloaded(from: filter.image)
            cell.timeLabel.text = filter.duration
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryRecipesCell") as! CategoryRecipesCell
            let item = items[indexPath.row]
            cell.categoryName.text = item.name
            cell.items = recipes[item] ?? []
            return cell
        }
    }

}
