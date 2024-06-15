//
//  ProfileViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Alexander Salagubov on 13.06.2024.
//

import Foundation
import Foundation
@testable import ImageFeed

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
  var view: ProfileViewControllerProtocol?
  var viewDidLoadCalled: Bool = false
  var notificationObserverCalled: Bool = false
  var didTapLogoutButtonCalled = true

  func viewDidLoad() {
    viewDidLoadCalled = true
  }

  func notificationObserver() {
    notificationObserverCalled = true
  }

  func updateAvatar() {
  }

  func didTapLogoutButton() {
    didTapLogoutButtonCalled = true
  }
}
