//
//  RecipeCoordinator.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 08/02/2021.
//

import Foundation
import UIKit

protocol RecipeCoordinatorDelegate {
    func navigateToRecipeDetailsViewController(recipe: Recipe)
}

class RecipeCoordinator: Coordinator, RecipeCoordinatorDelegate {
    
    func navigateToRecipeDetailsViewController(recipe: Recipe) {
        let destinationController: RecipeDetailsViewController? = viewController?.instantiateFromStoryboard(viewController: "RecipeDetailsViewController")
        if let destinationController = destinationController {
            destinationController.recipe = recipe
            viewController?.navigationController?.pushViewController(destinationController, animated: true)
        }
    }
}
