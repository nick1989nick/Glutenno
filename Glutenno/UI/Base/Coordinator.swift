//
//  Coordinator.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 03/02/2021.
//

import Foundation
import UIKit

protocol CoordinatorDelegate {
    
    func push(to viewController: UIViewController)
    func present(to viewController: UIViewController)
    func pop()
}

class Coordinator: CoordinatorDelegate {
   
    weak var viewController: BaseViewController?
    
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    func push(to viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(to viewController: UIViewController) {
        self.viewController?.present(viewController, animated: true, completion: nil)
    }
    
    func pop() {
        if let navigationController = viewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true, completion: nil)
        }
    }
 
}
