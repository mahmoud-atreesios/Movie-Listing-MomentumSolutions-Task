//
//  BannerCollectionViewCell.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerImageView.layer.cornerRadius = 20
        bannerImageView.clipsToBounds = true
    }

}
