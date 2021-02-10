//
//  RecipesViewModel.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 05/02/2021.
//

import Foundation
import UIKit
import RxSwift

protocol RecipesViewModelDelegate: ViewModelDelegate {
    func getData()
    func showRecipe(recipe: Recipe)
}


class RecipesViewModel: ViewModel, RecipesViewModelDelegate {
 
    let apiService: ApiService
    let recipesView: RecipesView
    let coordinator: RecipeCoordinator
    
    init(apiService: ApiService, recipesView: RecipesView, coordinator: RecipeCoordinator) {
        self.apiService = apiService
        self.recipesView = recipesView
        self.coordinator = coordinator
    }
    
    func getData() {
        apiService.getCategories()
            .do(onSuccess: { (categories) in
                self.recipesView.showCategories(category: categories)
            })
            .asObservable()
            .enumerated()
            .flatMap { [unowned self] (index, categories) -> Observable<(category:Category, recipes:[Recipe])> in
                let category = categories[index]
                return self.apiService.getRecipes(categoryId: category.id)
                    .map { (recipes) -> (category:Category, recipes:[Recipe]) in
                        return (category, recipes)
                    }.asObservable()
            }
            .toArray()
            .flatMap { (items) -> Single<[Category: [Recipe]]> in
                let dictionary = items.reduce([Category: [Recipe]]()) { (dict, tuple) -> [Category: [Recipe]] in
                    var dict = dict
                    dict[tuple.category] = tuple.recipes
                    return dict
                }
                return Single.just(dictionary)
            }
            .subscribe { (event) in
                switch event {
                case .success(let items):
                    self.recipesView.showItems(recipes: items)
                case .failure:
                    self.recipesView.showError(message: "There was an error, please try later.")
                }
            }.disposed(by: disposeBag)
    }
    
    func showRecipe(recipe: Recipe) {
        coordinator.navigateToRecipeDetailsViewController(recipe: recipe)
    }

}
