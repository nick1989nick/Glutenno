//
//  CategoryRouter.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 05/02/2021.
//

import Foundation
import UIKit
import Alamofire

enum Router: ApiConfiguration {
  
    case categories
    case recipes(id: String)
    
    var method: HTTPMethod {
        switch self {
        case .categories:
            return .get
        case .recipes:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/categories"
        case .recipes(let id):
            return "/recipes/\(id)"
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: ApiService.baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        if let params = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return request
    }

}

