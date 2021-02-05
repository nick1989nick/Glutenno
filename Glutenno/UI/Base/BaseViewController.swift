//
//  BaseViewController.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 03/02/2021.
//

import Foundation
import UIKit
import RxSwift

protocol BaseView {
    var coordinator: CoordinatorDelegate? {get}
}

class BaseViewController: UIViewController, BaseView {
    
    public var coordinator: CoordinatorDelegate?
    public let apiService = ApiService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator = Coordinator(viewController: self)
    }
    
    func instantiateFromStoryboard<T>(_ storyboard: String = "Main", viewController: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: viewController)
        return viewController as! T
    }
    
    
}
