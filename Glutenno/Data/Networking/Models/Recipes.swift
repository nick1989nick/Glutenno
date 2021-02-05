//
//  Recipes.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 03/02/2021.
//

import Foundation
import UIKit


struct Recipe: Codable {
    
    let id: String
    let name: String
    let duration: String
    let description: String
    let image: String
    let ingredients: [Ingredient]
    let steps: [Step]
}
