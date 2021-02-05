//
//  ViewModel.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 03/02/2021.
//

import Foundation
import RxSwift

protocol ViewModelDelegate {
    var disposeBag: DisposeBag {get}
}

class ViewModel: ViewModelDelegate {
    
    public let disposeBag = DisposeBag()
}

