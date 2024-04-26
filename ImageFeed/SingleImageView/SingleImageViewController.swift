//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Alexander Salagubov on 17.04.2024.
//

import Foundation
import UIKit

final class SingleImageViewController: UIViewController {
  var image: UIImage? {
    didSet{
      guard isViewLoaded else { return }
      imageView.image = image
    }
  }

  @IBOutlet private var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let image else { return }
    imageView.image = image
    imageView.frame.size = image.size
    scrollView.minimumZoomScale = 0.1
    scrollView.maximumZoomScale = 1.25
    rescaleAndCenterImageInScrollView(image: image)
  }
  @IBAction private func didTapBackButton() {
    dismiss(animated: true, completion: nil)
  }
  @IBAction private func didTapShareButton() {
    guard let image else { return }
    let share = UIActivityViewController(
        activityItems: [image],
        applicationActivities: nil
    )
    present(share, animated: true, completion: nil)
}
}

extension SingleImageViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    imageView
  }
}

extension SingleImageViewController {
  private func rescaleAndCenterImageInScrollView(image: UIImage) {
    let minZoomScale = scrollView.minimumZoomScale
    let maxZoomScale = scrollView.maximumZoomScale
    view.layoutIfNeeded()
    let visibleRectSize = scrollView.bounds.size
    let imageSize = image.size
    let hScale = visibleRectSize.width / imageSize.width
    let vScale = visibleRectSize.height / imageSize.height
    let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
    scrollView.setZoomScale(scale, animated: false)
    scrollView.layoutIfNeeded()
    let newContentSize = scrollView.contentSize
    let x = (newContentSize.width - visibleRectSize.width) / 2
    let y = (newContentSize.height - visibleRectSize.height) / 2
    scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
  }
}
