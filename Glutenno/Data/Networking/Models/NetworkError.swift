//
//  NetworkError.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 02/02/2021.
//

import Foundation

enum NetworkError: Int, Error {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case conflict = 409
    case serverError = 500
    case gone = 410
    case unknown
}
