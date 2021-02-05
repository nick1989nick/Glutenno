//
//  ApiConfiguration.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 02/02/2021.
//

import Foundation
import Alamofire

protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod {get}
    var path: String {get}
    var parameters: Parameters? {get}    
}
