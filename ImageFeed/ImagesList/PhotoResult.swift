//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 25.05.2024.
//

import Foundation

struct PhotoResult: Codable {
  let id: String
  let createdAt: Date
  let width: Int
  let height: Int
  let likedByUser: Bool
  let description: String?
  let urls: UrlsResult
  
  enum CodingKeys: String, CodingKey {
    case id
    case createdAt = "created_at"
    case width
    case height
    case likedByUser = "liked_by_user"
    case description
    case urls
  }
}
