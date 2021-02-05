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

class RecipiesViewController: BaseViewController, RecipesView {
  
    @IBOutlet var tableView: UITableView!
    
    var items = [Category]()
    var recipes: [Category: [Recipe]] = [:] {
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

   
}

extension RecipiesViewController: UITableViewDelegate {
    
}

extension RecipiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryRecipesCell") as! CategoryRecipesCell
        let item = items[indexPath.row]
        cell.categoryName.text = item.name
        cell.items = recipes[item] ?? []
        return cell
    }

}
