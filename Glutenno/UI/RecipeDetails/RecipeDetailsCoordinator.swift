//
//  RecipeDetailsCoordinator.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 08/02/2021.
//

import Foundation
import UIKit

protocol RecipeDetailsCoordinatorDelegate: CoordinatorDelegate {
    func navigateToRecipeStepsViewController(steps: [Step])
}

class RecipeDetailsCoordinator: Coordinator, RecipeDetailsCoordinatorDelegate {
    func navigateToRecipeStepsViewController(steps: [Step]) {
        let destinationController: PagerViewController? = viewController?.instantiateFromStoryboard(viewController: "PagerViewController")
        if let destinationController = destinationController {
            destinationController.steps = steps
            viewController?.present(destinationController, animated: true, completion: nil)
        }
    }
}
