//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 12.04.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
  
  private let avatarImageView = UIImageView(image: .avatar)
  private let service = ProfileService()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Екатерина Новикова"
    label.textColor = .ypWhite
    label.font = .systemFont(ofSize: 23, weight: .bold)
    return label
  }()
  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.text = "@ekaterina_nov"
    label.textColor = .ypGray
    label.font = .systemFont(ofSize: 13, weight: .regular)
    return label
  }()
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Hello, World!"
    label.textColor = .ypWhite
    label.font = .systemFont(ofSize: 13, weight: .regular)
    return label
  }()
  private let logoutButton: UIButton = {
    let button = UIButton.systemButton(
      with: UIImage(systemName: "ipad.and.arrow.forward")!,
      target: self,
      action: #selector(Self.didTapLogoutButton)
    )
    button.tintColor = .ypRed
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    [avatarImageView,
     nameLabel,
     userNameLabel,
     descriptionLabel,
     logoutButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    avatarSet()
    nameLabelSet()
    userNameLabelSet()
    descriptionLabelSet()
    logoutButtonSet()
    loadData()
  }
  
  private func avatarSet() {
    avatarImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    avatarImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
  }
  
  private func nameLabelSet() {
    nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
    nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8).isActive = true
  }
  
  private func userNameLabelSet() {
    userNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
    userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
  }
  
  private func descriptionLabelSet() {
    descriptionLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor).isActive = true
    descriptionLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8).isActive = true
  }
  
  private func logoutButtonSet() {
    logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
  }

  private func loadData() {
    service.fetchProfile(OAuth2TokenStorage().token!) { result in
      guard case let .success(profile) = result else { return /* error */ }
      DispatchQueue.main.async {
        self.nameLabel.text = profile.name
        self.userNameLabel.text = profile.loginName
        self.descriptionLabel.text = profile.bio
      }
    }
  }

  
  @objc
  private func didTapLogoutButton(_ sender: Any) {
  }


}
