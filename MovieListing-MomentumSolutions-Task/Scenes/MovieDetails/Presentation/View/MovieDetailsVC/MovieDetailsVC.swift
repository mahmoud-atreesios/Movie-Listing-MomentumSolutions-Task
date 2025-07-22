//
//  MovieDetailsVC.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieVoteAverage: UILabel!
    @IBOutlet weak var movieOriginalLanguage: UILabel!
    
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        updateFavouriteButtonImage()
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        updateFavouriteButtonImage()
    }
    
    private func updateFavouriteButtonImage() {
        let imageName = favouriteButton.isSelected ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)
        favouriteButton.setImage(image, for: .normal)
        favouriteButton.tintColor = .red
    }
    
    
}
