//
//  RecipeDetailsViewModel.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 08/02/2021.
//

import Foundation
import UIKit
import RxSwift

protocol RecipeDetailsViewModelDelegate: ViewModelDelegate {
    func onStartButtonTapped(steps: [Step])
}

class RecipeDetailsViewModel: ViewModel, RecipeDetailsViewModelDelegate {
    
    let apiService: ApiService
    let recipeDetailsView: RecipeDetailsView
    let coordinator: RecipeDetailsCoordinator
    
    init(apiService: ApiService, recipeDetailsView: RecipeDetailsView, coordinator: RecipeDetailsCoordinator) {
        self.apiService = apiService
        self.recipeDetailsView = recipeDetailsView
        self.coordinator = coordinator
    }
  
    func onStartButtonTapped(steps: [Step]) {
        coordinator.navigateToRecipeStepsViewController(steps: steps)
    }

}
