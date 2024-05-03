//
//  Constants.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 29.04.2024.
//

import Foundation

enum Constants {
  static let accessKey = "<ваш Access Key>"
  static let secretKey = "<ваш Secret Key>"
  static let redirectURI = "<ваш Redirect URI>"
  static let accessScope = "public+read_user+write_likes"
  static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
}