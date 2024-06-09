//
//  UrlsResult.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 25.05.2024.
//

import Foundation

struct UrlsResult: Codable {
  let raw: String
  let full: String
  let regular: String
  let small: String
  let thumb: String
}
