//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 25.05.2024.
//

import Foundation


final class ImagesListService {

  private (set) var photos: [Photo] = []
  private var lastLoadedPage: Int?
  private var task: URLSessionTask?
  private let urlSession = URLSession.shared

  static let shared = ImagesListService()
  static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
  private init() {}

  func makePhotoRequest(page: Int, per_page: Int) -> URLRequest? {
    let baseURL = Constants.baseURL

    var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    components?.path = "/photos"
    components?.queryItems = [
      URLQueryItem(name: "page", value: "\(page)"),
      URLQueryItem(name: "per_page", value: "\(per_page)"),
      URLQueryItem(name: "client_id", value: Constants.accessKey),
    ]

    guard let url = components?.url else {
      assertionFailure("Failed to create URL")
      return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    return request
  }

  func fetchPhotosNextPage(completion: @escaping (Result<[Photo], Error>) -> Void) {
    assert(Thread.isMainThread)
    task?.cancel()
    let nextPage = (lastLoadedPage ?? 0) + 1

    guard let request = makePhotoRequest(page: nextPage, per_page: 10) else {
      completion(.failure(AuthServiceError.invalidRequest))
      return
    }

    let task = urlSession.objectTask(for: request){ [weak self] (result: Result<[PhotoResult], Error>)  in
      guard let self else { return }
      switch result {
      case .success(let responsePhoto):
        let newPhoto = responsePhoto.map { Photo(photoResult: $0) }
        DispatchQueue.main.async {
          self.photos.append(contentsOf: newPhoto)
          self.lastLoadedPage = nextPage
          NotificationCenter.default.post(name: ImagesListService.didChangeNotification, object: nil)
          completion(.success(self.photos))
        }
      case .failure(let error):
        print("[ImagesListService]: AuthServiceError - \(error)")
        completion(.failure(error))
      }
      self.task = nil
    }
    self.task = task
    task.resume()
  }
}
