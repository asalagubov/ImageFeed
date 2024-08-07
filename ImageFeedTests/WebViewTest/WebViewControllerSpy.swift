//
//  WebViewViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Alexander Salagubov on 13.06.2024.
//

import ImageFeed
import Foundation

final class WebViewViewControllerSpy: WebViewViewControllerProtocol {
  var presenter: ImageFeed.WebViewPresenterProtocol?

  var loadRequestCalled: Bool = false

  func load(request: URLRequest) {
    loadRequestCalled = true
  }

  func setProgressValue(_ newValue: Float) {

  }

  func setProgressHidden(_ isHidden: Bool) {

  }
}
