//
//  ImagesListViewTests.swift
//  ImageFeedTests
//
//  Created by Alexander Salagubov on 15.06.2024.
//

import Foundation
@testable import ImageFeed
import XCTest

final class ImagesListViewTests: XCTestCase {
  func testViewControllerCallsViewDidLoad() {

    let viewController = ImagesListViewController()
    let presenter = ImagesListViewPresenterSpy()
    presenter.view = viewController
    viewController.presenter = presenter

    presenter.viewDidLoad()

    XCTAssertTrue(presenter.viewDidLoadCalled)
  }

  func testUpdateTableViewAnimated() {

    let viewController = ImagesListViewControllerSpy()
    let presenter = ImagesListViewPresenterSpy()
    presenter.view = viewController
    viewController.presenter = presenter

    viewController.updateTableViewAnimated()

    XCTAssertTrue(viewController.tableViewUpdatesCalled)
  }

  func testChangeLike() {

    let expectation = XCTestExpectation(description: "Change like")
    let presenter = ImagesListViewPresenterSpy()

    presenter.changeLike(photoId: "PhotoId", isLiked: true) { _ in
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 5)

    XCTAssertTrue(presenter.isLiked)
  }
  func testFetchPhotosNextPage() {
    let presenter = ImagesListViewPresenterSpy()
    presenter.fetchPhotosNextPage()

    XCTAssertTrue(presenter.fetchPhotosNextPageCalled)
  }

  func testConfigDate() {
    let presenter = ImagesListViewPresenterSpy()
    let date = "2023-06-03T12:34:56Z"
    let formattedDate = presenter.configDate(from: date)

    XCTAssertEqual(formattedDate, "3 июня 2023", "Date should be formatted correctly")
  }
}
