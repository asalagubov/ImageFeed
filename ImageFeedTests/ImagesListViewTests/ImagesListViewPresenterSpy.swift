//
//  ImagesListViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Alexander Salagubov on 15.06.2024.
//

import Foundation
@testable import ImageFeed
import UIKit


final class ImagesListViewPresenterSpy: ImagesListViewPresenterProtocol {

  var view: ImagesListViewControllerProtocol?
  var viewDidLoadCalled: Bool = false
  var notificationObserverCalled: Bool = false
  var isLiked: Bool = false
  var fetchPhotosNextPageCalled: Bool = false

  func viewDidLoad() {
    viewDidLoadCalled = true
  }


  func changeLike(photoId: String, isLiked: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
      self.isLiked = isLiked
      completion(.success(()))
    }
  }
  func fetchPhotosNextPage() {
    fetchPhotosNextPageCalled = true
  }

  func configDate(from date: String) -> String? {
    let dateFormatter8601 = ISO8601DateFormatter()
    guard let date = dateFormatter8601.date(from: date) else { return nil }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM yyyy"
    dateFormatter.locale = Locale(identifier: "ru_RU")

    return dateFormatter.string(from: date)
  }
}
