//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 20.05.2024.
//

import Foundation

struct ProfileResult: Codable {
  let username: String
  let first_name: String
  let last_name: String
  let bio: String?
  let profile_image: UserResult
}
