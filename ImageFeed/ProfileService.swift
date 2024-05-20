//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 20.05.2024.
//

import Foundation

final class ProfileService {
  private let urlSession = URLSession.shared
  private var task: URLSessionTask?
  private let decoder: JSONDecoder = JSONDecoder()
  static let shared = ProfileService()
  private(set) var profile: Profile?
  private var lastToken: String?

  private func makeInfoRequest(token: String) -> URLRequest? {
    let baseURL = Constants.defaultBaseURL

    var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    components?.path = "/me"

    guard let url = components?.url else {
      assertionFailure("Failed to create URL")
      return nil
    }
    var request = URLRequest(url: url)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    return request
  }

  func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
    assert(Thread.isMainThread)
    task?.cancel()
    lastToken = token

    guard let request = makeInfoRequest(token: token) else {
      completion(.failure(AuthServiceError.invalidRequest))
      return
    }

    let task = urlSession.data(for: request){ [weak self] result  in
      guard let self else { return }
      switch result {
      case .success(let data):
        do {
          let profileResponse = try decoder.decode(ProfileResult.self, from: data)
          self.profile = Profile.init(editorProfile: profileResponse)
          completion(.success(Profile(editorProfile: profileResponse)))
        } catch {
          print("Error decoding profile response:", error)
          completion(.failure(error))
        }
      case .failure(let error):
        print("Network error:", error)
        completion(.failure(error))
      }
      self.lastToken = nil
      self.task = nil
    }
    task.resume()
  }
}
