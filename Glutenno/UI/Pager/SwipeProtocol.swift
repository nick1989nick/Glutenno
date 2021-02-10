//
//  SwipeProtocol.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 09/02/2021.
//

import Foundation

enum Direction {
    case left, right
}

protocol SwipeProtocol {
    func swipe(direction: Direction)
}
