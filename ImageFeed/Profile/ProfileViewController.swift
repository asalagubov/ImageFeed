//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 12.04.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var logoutButton: UIButton!
  @IBAction func didTapLogoutButton(_ sender: Any) {
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: 16)
    ])
  }
}
