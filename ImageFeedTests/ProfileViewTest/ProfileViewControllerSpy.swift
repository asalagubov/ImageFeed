//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Alexander Salagubov on 13.06.2024.
//

import Foundation
@testable import ImageFeed
import UIKit

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {

  var presenter: ImageFeed.ProfileViewPresenterProtocol?

  func updateAvatar() {
  }

  func displayProfileData(name: String?, loginName: String?, bio: String?) {
  }

  func displayAvatar(image: UIImage?) {

  }
}
