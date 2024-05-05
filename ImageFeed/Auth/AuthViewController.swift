//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 02.05.2024.
//

import Foundation
import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
  
  private let ShowWebViewSegueIdentifier = "ShowWebView"

  weak var delegate: AuthViewControllerDelegate?

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == ShowWebViewSegueIdentifier {
      guard
        let webViewViewController = segue.destination as? WebViewViewController
      else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
      webViewViewController.delegate = self
    } else {
      super.prepare(for: segue, sender: sender)
    }
  }
}

extension AuthViewController: WebViewViewControllerDelegate {
  func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
    vc.dismiss(animated: true)
    OAuth2Service.shared.fetchOAuthToken(code: code) { result in
      switch result {
      case .success(let token):
        print("Successfully fetched OAuth token:", token)
      case .failure(let error):
        print("Failed to fetch OAuth token:", error)
      }
    }
  }
  
  func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
    dismiss(animated: true)
  }
}
