//
//  SecureStorage.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 02/02/2021.
//

import Foundation
import KeychainSwift

class SecureStorage {
    
    static let shared = SecureStorage()
    
    private let keychain = KeychainSwift()
    
    private init() {
        
    }
}

