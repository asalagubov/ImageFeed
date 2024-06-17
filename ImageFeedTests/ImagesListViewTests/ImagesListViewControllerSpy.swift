//
//  ImagesListViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Alexander Salagubov on 15.06.2024.
//

import Foundation
@testable import ImageFeed

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
  
  var presenter: ImagesListViewPresenterProtocol?
  var tableViewUpdatesCalled: Bool =  false
  
  func updateTableViewAnimated() {
    tableViewUpdatesCalled = true
  }
}
