//
//  RecommendedMoviesCollectionViewCell.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//

import UIKit

class RecommendedMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRealeseDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateFavouriteButtonImage()
        posterImageView.setCornerRadius(10)
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        updateFavouriteButtonImage()
    }
    
}

extension RecommendedMoviesCollectionViewCell {
    private func updateFavouriteButtonImage() {
        let imageName = favouriteButton.isSelected ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)
        favouriteButton.setImage(image, for: .normal)
    }
}
