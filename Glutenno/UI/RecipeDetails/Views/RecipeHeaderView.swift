//
//  RecipeHeaderView.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 08/02/2021.
//

import UIKit

class RecipeHeaderView: UIView {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var timeImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var time: UILabel!


    func setup(recipe: Recipe) {
        image.downloaded(from: recipe.image)
        name.text = recipe.name
        time.text = recipe.duration
    }
}
