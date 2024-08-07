//
//  Photo.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 25.05.2024.
//

import Foundation


struct Photo {
  let id: String
  let size: CGSize
  let createdAt: String?
  let welcomeDescription: String
  let thumbImageURL: String
  let largeImageURL: String
  let fullImageURL: String
  var isLiked: Bool

  init(photoResult: PhotoResult) {
    self.id = photoResult.id 
    self.size = CGSize(width: photoResult.width, height: photoResult.height)
    self.createdAt = photoResult.createdAt
    self.welcomeDescription = photoResult.description ?? ""
    self.thumbImageURL = photoResult.urls.thumb
    self.largeImageURL = photoResult.urls.full
    self.fullImageURL = photoResult.urls.full
    self.isLiked = photoResult.likedByUser ?? false
  }
}
