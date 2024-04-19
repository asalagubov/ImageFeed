//
//  ViewController.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 28.03.2024.
//

import UIKit

final class ImagesListViewController: UIViewController {
  private let showSingleImageSegueController = "ShowSingleImage"

  @IBOutlet private weak var tableView: UITableView!
  
  private let photosName: [String] = Array(0..<20).map{ "\($0)" }
  
  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == showSingleImageSegueController {
      guard
        let viewController = segue.destination as? SingleImageViewController,
        let indexPatch = sender as? IndexPath
      else {
        assertionFailure("Invalid segue destination")
        return
      }
      let image = UIImage(named: photosName[indexPatch.row])
      viewController.image = image
    } else {
      super.prepare(for: segue, sender: sender)
    }
  }
}

extension ImagesListViewController {
  func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
    guard let image = UIImage(named: photosName[indexPath.row]) else {
      return
    }
    
    cell.cellImage.image = image
    cell.dateLabel.text = dateFormatter.string(from: Date())
    
    let isLike = indexPath.row % 2 == 0
    let likeImage = UIImage(named: isLike ? "like_button_on" : "like_button_off")
    cell.likeButton.setImage(likeImage, for: .normal)
  }
}

extension ImagesListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photosName.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reiseIdentifier, for: indexPath)
    
    guard let imageListCell = cell as? ImagesListCell else {
      return UITableViewCell()
    }
    configCell(for: imageListCell, with: indexPath)
    return imageListCell
  }
}

extension ImagesListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: showSingleImageSegueController, sender: indexPath)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let image = UIImage(named: photosName[indexPath.row]) else {
      return 0
    }

    let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
    let imageWidth = image.size.width
    let scale = imageViewWidth / imageWidth
    let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
    return cellHeight
  }
}
