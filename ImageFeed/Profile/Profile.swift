//
//  Profile.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 20.05.2024.
//

import Foundation

struct Profile {
  let userName: String
  let name: String
  let loginName: String
  let bio: String?

  init(editorProfile: ProfileResult) {
    self.userName = editorProfile.username
    self.name = editorProfile.firstName + " " + (editorProfile.lastName ?? "")
    self.loginName = "@" + editorProfile.username
    self.bio = editorProfile.bio ?? ""
  }
}
