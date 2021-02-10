//
//  SuccessViewController.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 09/02/2021.
//

import Foundation
import UIKit
import Lottie
import RxSwift

protocol FocusProtocol {
    func onScreenFocused()
}

class SuccessViewController: BaseViewController, FocusProtocol {
 
    @IBOutlet var checkbox: UIView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
    let animationView = AnimationView()
    let successAnimation: Animation = Animation.named("15647-yellow-check")!
    var swipeProtocol: SwipeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.rx.tap.bind {[unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
        backButton.rx.tap.bind {[unowned self] in
            self.swipeProtocol?.swipe(direction: .left)
        }
        animationView.contentMode = .scaleAspectFit
        
        checkbox.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: checkbox.layoutMarginsGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: checkbox.leadingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: checkbox.bottomAnchor, constant: -12).isActive = true
        animationView.trailingAnchor.constraint(equalTo: checkbox.trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        animationView.animation = successAnimation
        
    }
    
    func onScreenFocused() {
        playAnimation()
    }

    func playAnimation() {
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.playOnce,
                           completion: { (finished) in
                            if finished {
                              print("Animation Complete")
                            } else {
                              print("Animation cancelled")
                            }
        })
    }
    
    
}
