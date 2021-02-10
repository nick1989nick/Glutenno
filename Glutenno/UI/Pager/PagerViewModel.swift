//
//  PagerViewModel.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 09/02/2021.
//

import Foundation
import UIKit

protocol PagerViewModelDelegate: ViewModelDelegate {
    
}

class PagerViewModel: ViewModel, PagerViewModelDelegate {
    
    let apiService: ApiService
    let pagerViewDelegate: PagerViewDelegate
    
    init(apiService: ApiService, pagerViewDelegate: PagerViewDelegate) {
        self.apiService = apiService
        self.pagerViewDelegate = pagerViewDelegate
    }
}
