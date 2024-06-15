//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Alexander Salagubov on 28.03.2024.
//

import XCTest

final class ImageFeedUITests: XCTestCase {

  private let app = XCUIApplication() // переменная приложения

  override func setUpWithError() throws {
    continueAfterFailure = false // настройка выполнения тестов, которая прекратит выполнения тестов, если в тесте что-то пошло не так

    app.launch() // запускаем приложение перед каждым тестом
  }

  func testAuth() throws {

    XCTAssertTrue(app.buttons["Authenticate"].waitForExistence(timeout: 3))
    app.buttons["Authenticate"].tap()

    let webView = app.webViews["UnsplashWebView"]
    XCTAssertTrue(webView.waitForExistence(timeout: 3))

    let loginTextField = webView.descendants(matching: .textField).element
    XCTAssertTrue(loginTextField.waitForExistence(timeout: 3))

    loginTextField.tap()
    loginTextField.typeText("salagubov@icloud.com")

    let passwordTextField = webView.descendants(matching: .secureTextField).element
    XCTAssertTrue(passwordTextField.waitForExistence(timeout: 3))
    XCUIApplication().toolbars.buttons["Done"].tap()

    passwordTextField.tap()
    passwordTextField.typeText("Salagubov")
    webView.tap()
    sleep(1)

    XCTAssertTrue(webView.buttons["Login"].waitForExistence(timeout: 3))
    webView.buttons["Login"].tap()


    let tableQuery = app.tables
    let cell = tableQuery.children(matching: .cell).element(boundBy: 0)
    XCTAssertTrue(cell.waitForExistence(timeout: 5))
  }

  func testFeed() throws {
    let tablesQuery = app.tables

    let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
    cell.swipeUp()

    sleep(2)

    let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)

    cellToLike.buttons["likeButton"].tap()
    cellToLike.buttons["likeButton"].tap()

    sleep(2)

    cellToLike.tap()

    sleep(2)

    let image = app.scrollViews.images.element(boundBy: 0)
    // Zoom in
    image.pinch(withScale: 3, velocity: 1) // zoom in
    // Zoom out
    image.pinch(withScale: 0.5, velocity: -1)

    let navBackButtonWhiteButton = app.buttons["nav back button white"]
    navBackButtonWhiteButton.tap()
  }

  func testProfile() throws {
    app.tabBars.buttons.element(boundBy: 1).tap()

    XCTAssertTrue(app.staticTexts["Aleksandr Salagubov"].exists)
    XCTAssertTrue(app.staticTexts["@salagubov"].exists)
    sleep(2)
    app.buttons["logoutButton"].tap()
    sleep(2)
    let logoutAlert = app.alerts["Пока, пока!"]
    XCTAssertTrue(logoutAlert.exists, "Logout alert does not exist")
    logoutAlert.buttons["Да"].tap()
    XCTAssertTrue(app.buttons["Authenticate"].waitForExistence(timeout: 3))

  }
}
