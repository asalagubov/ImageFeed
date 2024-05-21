//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 20.05.2024.
//

import Foundation

struct ProfileResult: Codable {
  let username: String
  let firstName: String
  let lastName: String
  let bio: String?
  let profileImage: UserResult
}
