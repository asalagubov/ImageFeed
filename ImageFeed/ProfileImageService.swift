//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 20.05.2024.
//

import Foundation


final class ProfileImageService {
  static let shared = ProfileImageService()
  static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
  private (set) var avatarURL: String?
  private var task: URLSessionTask?
  private let urlSession = URLSession.shared
  private let token = OAuth2TokenStorage()
  private let decoder: JSONDecoder = JSONDecoder()
  private init () {}

  private func makeProfileInfoRequest(token: String, username: String) -> URLRequest? {
    let baseURL = Constants.defaultBaseURL

    var imageURL = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    imageURL?.path = "/users/\(username)"

    guard let url = imageURL?.url else {
      assertionFailure("Failed to create URL")
      return nil
    }
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    return request
  }


  func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
    assert(Thread.isMainThread)
    task?.cancel()

    guard let request = makeProfileInfoRequest(token: token.token!, username: username) else {
      completion(.failure(AuthServiceError.invalidRequest))
      return
    }

    let task = urlSession.data(for: request){ [weak self] result  in
      guard let self else { return }
      switch result {
      case .success(let data):
        do {
          let profileResponse = try decoder.decode(ProfileResult.self, from: data)
          let avatarURL = profileResponse.profile_image.small
          completion(.success(avatarURL))
          print("Image has been uploaded ")

          NotificationCenter.default.post(
                  name: ProfileImageService.didChangeNotification,
                  object: self,
                  userInfo: ["URL": avatarURL])
        } catch {
          print("Image has been error", error)
          completion(.failure(error))
        }
      case .failure(let error):
        print("Network error:", error)
        completion(.failure(error))
      }
      self.task = nil
    }
    task.resume()
  }
}
