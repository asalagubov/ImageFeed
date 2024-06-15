//
//  ProfileViewTests.swift
//  ImageFeedTests
//
//  Created by Alexander Salagubov on 13.06.2024.
//

import Foundation
@testable import ImageFeed
import XCTest


final class ProfileViewTests: XCTestCase {

  func testViewControllerCallsViewDidLoad() {

    let viewController = ProfileViewController()
    let presenter = ProfileViewPresenterSpy()
    viewController.presenter = presenter
    presenter.view = viewController

    presenter.viewDidLoad()

    XCTAssertTrue(presenter.viewDidLoadCalled)
  }

  func testViewControllerCallsNotificationObserver() {
    let viewController = ProfileViewController()
    let presenter = ProfileViewPresenterSpy()
    viewController.presenter = presenter
    presenter.view = viewController

    presenter.notificationObserver()

    XCTAssertTrue(presenter.notificationObserverCalled)
  }

  func testPresenterCallsDidTapLogoutButton() {
    let presenter = ProfileViewPresenterSpy()
    presenter.didTapLogoutButton()

    XCTAssertTrue(presenter.didTapLogoutButtonCalled)
  }

  func testViewControllerDidTapLogoutButtonCallsPresenter() {
    let viewController = ProfileViewController()
    let presenter = ProfileViewPresenterSpy()
    viewController.presenter = presenter
    presenter.view = viewController

    viewController.didTapLogoutButton(viewController.logoutButton)

    XCTAssertTrue(presenter.didTapLogoutButtonCalled)
  }
}
