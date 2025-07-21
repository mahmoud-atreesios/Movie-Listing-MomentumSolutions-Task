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
