//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 04.05.2024.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}
