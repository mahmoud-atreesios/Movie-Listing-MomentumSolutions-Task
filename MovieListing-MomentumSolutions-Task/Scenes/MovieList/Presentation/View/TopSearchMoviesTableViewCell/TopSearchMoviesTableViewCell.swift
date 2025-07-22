//
//  TopSearchMoviesTableViewCell.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import UIKit

class TopSearchMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterMovieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRealeaseDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterMovieImageView.setCornerRadius(10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

//MARK: - Configuration
extension TopSearchMoviesTableViewCell {
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
        movieRealeaseDate.text = movie.releaseDate
        movieRating.text = String(format: "%.1f", movie.voteAverage)
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster)") {
            loadingIndicator.startAnimating()
            
            posterMovieImageView.sd_setImage(with: url, completed: { [weak self] _, _, _, _ in
                self?.loadingIndicator.stopAnimating()
            })
        } else {
            posterMovieImageView.image = nil
            loadingIndicator.stopAnimating()
        }
    }

}
