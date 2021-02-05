//
//  ApiService.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 02/02/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Alamofire

class ApiService: NSObject {
    
    static var baseUrl: URL {
        return try! URL(string: "https://glutenno.redox.media")!
    }
    
    static let shared = ApiService()
    private let session: Session
    
    private override init() {
        let configuration = URLSessionConfiguration.default
        session = Alamofire.Session(configuration: configuration, delegate: Alamofire.SessionDelegate(), serverTrustManager: nil)
    }
    
    func getCategories() -> Single<[Category]> {
        return getRequestSingle(Router.categories)
    }
    
    func getRecipes(categoryId: String) -> Single<[Recipe]> {
        return getRequestSingle(Router.recipes(id: categoryId))
    }
    
    private func getRequestSingle<T : Codable>(_ urlConvertible: URLRequestConvertible) -> Single<T> {
        return Single.create { [unowned self] (event) -> Disposable in
            let request = self.session.request(urlConvertible)
                let _ = request.responseJSON { (data) in
                if let res = data.response, res.statusCode >= 200 && res.statusCode < 300, let data = data.data {
                    let decoded = try? JSONDecoder().decode(T.self, from: data)
                    if let decoded = decoded {
                        event(.success(decoded))
                        return
                    }
                    event(.failure(NetworkError.unknown))
                } else {
                    guard let statusCode = data.response?.statusCode else {
                        event(.failure(NetworkError.unknown))
                        return
                    }
                    event(.failure(NetworkError(rawValue: statusCode) ?? .unknown))
                }
            }
            return Disposables.create()
        }
        .subscribe(on: ConcurrentMainScheduler.instance)
        .observe(on: MainScheduler.instance)
    }
    
    private func getRequestCompletable(_ urlConvertible: URLRequestConvertible) -> Completable {
        return Completable.create { [unowned self] (event) -> Disposable in
            let _ = self.session.request(urlConvertible).responseJSON { (response) in
                if let res = response.response, res.statusCode >= 200 && res.statusCode < 300 {
                    event(.completed)
                } else {
                    guard let statusCode = response.response?.statusCode else {
                        event(.error(NetworkError.unknown))
                        return
                    }
                    event(.error(NetworkError(rawValue: statusCode) ?? .unknown))
                }
            }
            return Disposables.create()
        }
        .subscribe(on: ConcurrentMainScheduler.instance)
        .observe(on: MainScheduler.instance)
    }
}
