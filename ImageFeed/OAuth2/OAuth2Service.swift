//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 04.05.2024.
//

import Foundation

enum AuthServiceError: Error {
  case invalidRequest
}

final class OAuth2Service {
  static let shared = OAuth2Service()

  private let urlSession = URLSession.shared
  private var lastRequestCode: String?
  private var task: URLSessionTask?
  private let decoder: JSONDecoder = {
    let result = JSONDecoder()
    result.keyDecodingStrategy = .convertFromSnakeCase
    return result
  }()
  private init() {}

  func makeOAuthTokenRequest(code: String) -> URLRequest? {
    let baseURL = Constants.baseURL

    var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    components?.path = "/oauth/token"
    components?.queryItems = [
      URLQueryItem(name: "client_id", value: Constants.accessKey),
      URLQueryItem(name: "client_secret", value: Constants.secretKey),
      URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
      URLQueryItem(name: "code", value: code),
      URLQueryItem(name: "grant_type", value: "authorization_code")
    ]

    guard let url = components?.url else {
      assertionFailure("Failed to create URL")
      return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    return request
  }


  func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
    assert(Thread.isMainThread)
    guard lastRequestCode != code else {
      completion(.failure(AuthServiceError.invalidRequest))
      return
    }

    task?.cancel()
    lastRequestCode = code
    guard let request = makeOAuthTokenRequest(code: code) else {
      completion(.failure(AuthServiceError.invalidRequest))
      return
    }

    let task = urlSession.data(for: request){ [weak self] result  in
      guard let self else { return }
      switch result {
      case .success(let data):
        do {
          let tokenResponse = try decoder.decode(OAuthTokenResponseBody.self, from: data)
          let tokenStorage = OAuth2TokenStorage()
          tokenStorage.token = tokenResponse.accessToken // Save token to UserDefaults
          completion(.success(tokenResponse.accessToken))
        } catch {
          print("Error decoding token response:", error)
          completion(.failure(error))
        }
      case .failure(let error):
        print("Network error:", error)
        completion(.failure(error))
      }
      self.task = nil
      self.lastRequestCode = nil
    }
    task.resume()
  }
}
