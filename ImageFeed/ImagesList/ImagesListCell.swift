//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 02.04.2024.
//

import Foundation
import UIKit

final class ImagesListCell: UITableViewCell {
  static let reiseIdentifier = "ImagesListCell"

  @IBOutlet weak var cellImage: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var dateLabel: UILabel!
}
