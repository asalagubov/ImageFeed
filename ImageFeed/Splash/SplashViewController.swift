//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 05.05.2024.
//

import Foundation
import UIKit

final class SplashViewController: UIViewController {
  private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"

  private let oauth2TokenStorage = OAuth2TokenStorage()
  private let oauth2Service = OAuth2Service.shared
  private let profileService = ProfileService.shared
  private let profileImageService = ProfileImageService.shared

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if let token = oauth2TokenStorage.token {
      switchToTabBarController()
      fetchProfile(token)
    } else {
      // Show Auth Screen
      performSegue(withIdentifier: showAuthenticationScreenSegueIdentifier, sender: nil)
    }

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNeedsStatusBarAppearanceUpdate()
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }

  private func switchToTabBarController() {
    guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
    let tabBarController = UIStoryboard(name: "Main", bundle: .main)
      .instantiateViewController(withIdentifier: "TabBarViewController")
    window.rootViewController = tabBarController
  }
}

extension SplashViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == showAuthenticationScreenSegueIdentifier {
      guard
        let navigationController = segue.destination as? UINavigationController,
        let viewController = navigationController.viewControllers[0] as? AuthViewController
      else {
        assertionFailure("Failed to prepare for \(showAuthenticationScreenSegueIdentifier)")
        return
      }
      viewController.delegate = self
    } else {
      super.prepare(for: segue, sender: sender)
    }
  }
}

extension SplashViewController: AuthViewControllerDelegate {
  func authViewController(_ vc: AuthViewController, didAuthenticateWithCode token: String) {
    dismiss(animated: true) { [weak self] in
      guard let self = self else { return }
      self.switchToTabBarController()
    }
    fetchProfile(token)
  }

  func didAuthenticate(_ vc: AuthViewController) {
    vc.dismiss(animated: true)

    guard let token = oauth2TokenStorage.token else {
      return
    }

    fetchProfile(token)
  }

  private func fetchProfile(_ token: String) {
    UIBlockingProgressHUD.show()
    profileService.fetchProfile(token) { [weak self] result in
      UIBlockingProgressHUD.dismiss()

      guard let self = self else { return }

      switch result {
      case .success(let profileResult):
        let username = profileResult.userName 
        profileImageService.fetchProfileImageURL(username: username) { _ in }
        print("Parsing completed")
        self.switchToTabBarController()

      case .failure:

        // TODO [Sprint 11] Покажите ошибку получения профиля
        print("Parsing Data Error")
        break
      }
    }
  }
}
