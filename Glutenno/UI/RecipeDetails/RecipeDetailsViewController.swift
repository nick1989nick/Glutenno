//
//  RecipeDetailsViewController.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 08/02/2021.
//

import Foundation
import UIKit
import RxSwift


class RecipeDetailsViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var startButton: UIButton!
    
    var recipe: Recipe?
    var step: Step?
    var recipeHeader: RecipeHeaderView?
    var viewModel: RecipeDetailsViewModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let recipe = recipe else {
            return
        }
        
        viewModel = RecipeDetailsViewModel(apiService: apiService, coordinator: RecipeDetailsCoordinator(viewController: self))
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        recipeHeader = .fromNib()
        recipeHeader?.setup(recipe: recipe)

        tableView.tableHeaderView = recipeHeader
        
        startButton.rx.tap.bind {[unowned self] in
            self.viewModel?.onStartButtonTapped(steps: recipe.steps)
            }
    }
    
}

extension RecipeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.ingredients.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDescriptionCell") as! RecipeDescriptionCell
            let item = recipe?.description
            cell.recipeDescription.text = item?.description
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientCell") as! RecipeIngredientCell
            let item = recipe?.ingredients[indexPath.row - 1]
            cell.name.text = item?.name
            cell.quantity.text = item?.quantity
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}

class RecipeDescriptionCell: UITableViewCell {
    @IBOutlet var recipeDescription: UILabel!
}

class RecipeIngredientCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var quantity: UILabel!
}
