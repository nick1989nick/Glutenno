//
//  PagerViewController.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 09/02/2021.
//

import Foundation
import UIKit

protocol PagerViewDelegate {
    func swipeLeft()
    func swipeRight()
    
}

class PagerViewController: BaseViewController, PagerViewDelegate, SwipeProtocol {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    private var animationFinished = true
    private var pageWidth: CGFloat = 0.0
    
    var steps = [Step]()
    var viewModel: PagerViewModelDelegate?
    var successViewController: SuccessViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        viewModel = PagerViewModel(apiService: apiService, pagerViewDelegate: self)
        
        setup()
        setupConstraints()
        stackView.axis = .horizontal
        
        for step in steps {
            let recipeStepsViewController: RecipeStepsViewController = instantiateFromStoryboard(viewController: "RecipeStepsViewController")
            recipeStepsViewController.swipeProtocol = self
            recipeStepsViewController.step = step
            add(recipeStepsViewController)
            pageWidth = recipeStepsViewController.view.frame.width
        }
        
        successViewController = instantiateFromStoryboard(viewController: "SuccessViewController")
        successViewController?.swipeProtocol = self
        add(successViewController!)
    }
    
    func swipeLeft() {
        var offset = scrollView.contentOffset.x
        if  offset == 0 {
            return
        }
        offset -= pageWidth
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: { [unowned self] in
            self.scrollView.contentOffset = CGPoint(x: offset, y: 0)
            }, completion: nil)
    }
    
    func swipeRight() {
        
        var offset = scrollView.contentOffset.x
        offset += pageWidth
        if offset == pageWidth * CGFloat(steps.count) - pageWidth {
            successViewController?.onScreenFocused()
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: { [unowned self] in
            self.scrollView.contentOffset = CGPoint(x: offset, y: 0)
        }, completion: nil)
    }
    
    func swipe(direction: Direction) {
        switch direction {
        case .left:
            swipeLeft()
        case .right:
            swipeRight()
        }
    }
    
    func setup() {
        
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.addSubview(stackView)
      
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
       
       

        NSLayoutConstraint.activate([
 
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width * CGFloat(steps.count))
        ])
    }
    
}

extension PagerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension PagerViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        stackView.addArrangedSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        child.didMove(toParent: self)
    }

    func remove(_ child: UIViewController) {
        guard child.parent != nil else {
            return
        }

        child.willMove(toParent: nil)
        stackView.removeArrangedSubview(child.view)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
