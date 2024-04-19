//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 17.04.2024.
//

import Foundation
import UIKit

final class SingleImageViewController: UIViewController {
  var image: UIImage?

  @IBOutlet private var imageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = image
  }
}
