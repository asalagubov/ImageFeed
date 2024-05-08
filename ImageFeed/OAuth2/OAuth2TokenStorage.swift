//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 04.05.2024.
//

import Foundation

final class OAuth2TokenStorage {
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "OAuth2Token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "OAuth2Token")
        }
    }
}
