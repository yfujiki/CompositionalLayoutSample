//
//  ImageCollectionViewCell.swift
//  CompositionalLayoutSample
//
//  Created by Yuichi Fujiki on 23/6/19.
//  Copyright © 2019 Yuichi Fujiki. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    var cornerRadius: CGFloat = 0 {
        didSet {
            if cornerRadius > 0 {
                imageView.viewCornerRadius = cornerRadius
                imageView.clipsToBounds = true
                imageView.layer.masksToBounds = true
            } else {
                imageView.viewCornerRadius = 0
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
