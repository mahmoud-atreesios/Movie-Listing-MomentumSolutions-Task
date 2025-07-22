//
//  RecommendedMoviesCollectionViewCell.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//

import UIKit
import SDWebImage

class RecommendedMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRealeseDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
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

//MARK: - Configuration
extension RecommendedMoviesCollectionViewCell {
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
        movieRealeseDate.text = movie.releaseDate
        movieRating.text = String(format: "%.1f", movie.voteAverage)
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster)") {
            loadingIndicator.startAnimating()
            
            posterImageView.sd_setImage(with: url, completed: { [weak self] _, _, _, _ in
                self?.loadingIndicator.stopAnimating()
            })
        } else {
            posterImageView.image = nil
            loadingIndicator.stopAnimating()
        }
    }
}

//MARK: - Favourite button logic
extension RecommendedMoviesCollectionViewCell {
    private func updateFavouriteButtonImage() {
        let imageName = favouriteButton.isSelected ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)
        favouriteButton.setImage(image, for: .normal)
        favouriteButton.tintColor = .red
    }
}
