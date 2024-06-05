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

  //private let photosName: [String] = Array(0..<20).map{ "\($0)" }
  var photos: [Photo] = []
  let imageListService = ImagesListService.shared


  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    let dateFormatter = ISO8601DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    NotificationCenter.default.addObserver(self, selector: #selector(updateTableViewAnimated), name: ImagesListService.didChangeNotification, object: nil)
    imageListService.fetchPhotosNextPage()
  }
  deinit {
      NotificationCenter.default.removeObserver(self)
  }

  @objc private func updateTableViewAnimated() {
    let oldCount = photos.count
    let newCount = imageListService.photos.count
    photos = imageListService.photos
    if oldCount != newCount {
      tableView.performBatchUpdates {
        let indexPaths = (oldCount..<newCount).map { IndexPath(row: $0, section: 0) }
        tableView.insertRows(at: indexPaths, with: .automatic)
      }
    }
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
      let photo = photos[indexPatch.row]
      viewController.imageURL = URL(string: photo.fullImageURL)
      //      if let image = UIImage(named: photo.largeImageURL) {
      //        viewController.image = image }
    } else {
      super.prepare(for: segue, sender: sender)
    }
  }

  private func updatePhoto() {
    self.photos = ImagesListService.shared.photos
    self.tableView.performBatchUpdates {
      self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
  }
}


extension ImagesListViewController {
  func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
    let image = photos[indexPath.row]
    cell.dateLabel.text = dateFormatter.string(from: image.createdAt ?? Date())
    let likeImage = image.isLiked ? "like_button_on" : "like_button_off"
    cell.likeButton.setImage(UIImage(named: likeImage), for: .normal)
    cell.cellImage.kf.indicatorType = .activity
    cell.cellImage.kf.setImage(with: URL(string: image.largeImageURL), placeholder: UIImage(named: "Stub"))
    cell.delegate = self
  }
}

extension ImagesListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reiseIdentifier, for: indexPath)

    guard let imageListCell = cell as? ImagesListCell else {
      return UITableViewCell()
    }
    configCell(for: imageListCell, with: indexPath)
    return imageListCell
  }

  func tableView(_ tableView: UITableView,willDisplay cell: UITableViewCell,forRowAt indexPath: IndexPath) {
    if indexPath.row == photos.count - 1 {
      imageListService.fetchPhotosNextPage()
    }
  }
}

extension ImagesListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: showSingleImageSegueController, sender: indexPath)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let image = photos[indexPath.row]
    let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
    let imageWidth = image.size.width
    let scale = imageViewWidth / imageWidth
    let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
    return cellHeight
  }
}
extension ImagesListViewController: ImagesListCellDelegate {
  func imageListCellDidTapLike(_ cell: ImagesListCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let photo = photos[indexPath.row]
    let isLike = !photo.isLiked
    UIBlockingProgressHUD.show()
    ImagesListService.shared.changeLike(photoId: photo.id, isLike: isLike) { [weak self] result in
      switch result {
      case .success:
        DispatchQueue.main.async {
          if let index = self?.photos.firstIndex(where: { $0.id == photo.id }) {
            self?.photos[index].isLiked = isLike
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
          }
        }
        UIBlockingProgressHUD.dismiss()
      case .failure(let error):
        UIBlockingProgressHUD.dismiss()
        print("Failed to change like status: \(error)")
      }
    }
  }
}
