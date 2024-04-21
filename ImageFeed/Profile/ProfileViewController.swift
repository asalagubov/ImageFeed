//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 12.04.2024.
//

import UIKit

final class ProfileViewController: UIViewController {

  private var avatarImage = UIImage()
  private var avatarImageView = UIImageView(image: .avatar)
  private var nameLabel = UILabel()
  private var userNameLabel = UILabel()
  private var descriptionLabel = UILabel()
  private var logoutButton = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    avatarSet()
    nameLableSet()
    userNameLabelSet()
    descriptionLabelSet()
    logoutButtonSet()
  }

  private func avatarSet() {
    avatarImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(avatarImageView)

    avatarImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    avatarImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
  }

  private func nameLableSet() {
    nameLabel.text = "Екатерина Новикова"
    nameLabel.textColor = .ypWhite
    nameLabel.font = .systemFont(ofSize: 23, weight: .bold)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(nameLabel)

    nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
    nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8).isActive = true
  }

  private func userNameLabelSet() {
    userNameLabel.text = "@ekaterina_nov"
    userNameLabel.textColor = .ypGray
    userNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
    userNameLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(userNameLabel)

    userNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
    userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
  }

  private func descriptionLabelSet() {
    descriptionLabel.text = "Hello, World!"
    descriptionLabel.textColor = .ypWhite
    descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(descriptionLabel)

    descriptionLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor).isActive = true
    descriptionLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8).isActive = true
  }

  private func logoutButtonSet() {
    let button = UIButton.systemButton(
      with: UIImage(systemName: "ipad.and.arrow.forward")!,
      target: self,
      action: #selector(Self.didTapLogoutButton)
    )
    button.tintColor = .ypRed
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)

    button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    button.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true

  }


  @objc
  private func didTapLogoutButton(_ sender: Any) {
  }
}
