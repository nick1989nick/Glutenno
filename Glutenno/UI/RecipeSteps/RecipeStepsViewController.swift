//
//  StepsViewController.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 09/02/2021.
//

import Foundation
import UIKit

class RecipeStepsViewController: BaseViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleName: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backButton: UIButton!
   
    
    var swipeProtocol: SwipeProtocol?
    var step: Step?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let step = step else {
            return
        }
        tableView.dataSource = self
        tableView.separatorStyle = .none
    
        image.downloaded(from: step.image)
        image.isUserInteractionEnabled = true
        titleName.text = "Step \(step.order)"
        nextButton.rx.tap.bind { [unowned self] in
            self.swipeProtocol?.swipe(direction: .right)
        }
        backButton.rx.tap.bind { [unowned self] in
            self.swipeProtocol?.swipe(direction: .left)
        }
        
        backButton.isHidden = step.order == "1"
    }
}

class RecipeStepsCell: UITableViewCell {
    @IBOutlet var recipeDescription: UILabel!
}

extension RecipeStepsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeStepsCell") as! RecipeStepsCell
        cell.recipeDescription.text = step?.description
        cell.selectionStyle = .none
        return cell
    }
}
