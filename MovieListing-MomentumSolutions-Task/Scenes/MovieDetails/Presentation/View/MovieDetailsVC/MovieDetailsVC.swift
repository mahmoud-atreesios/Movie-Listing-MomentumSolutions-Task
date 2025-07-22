//
//  MovieDetailsVC.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import UIKit
import SDWebImage

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
    
    private let movie: Movie
    private let viewModel: MovieListViewModel

    init(movie: Movie, viewModel: MovieListViewModel) {
        self.movie = movie
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        setupMovieDetails()
        setupFavouriteButton()
        
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
        updateFavouriteButtonState()
    }
}

//MARK: - setup
extension MovieDetailsVC {
    
    // ui setup
    private func setupUI() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
    }
    
    // movie details setup
    private func setupMovieDetails() {
        movieTitle.text = movie.title
        movieRating.text = "\(movie.voteAverage)"
        movieReleaseDate.text = movie.releaseDate
        movieOriginalLanguage.text = movie.originalLanguage
        movieOverview.text = movie.overview
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster)") {
            
            moviePoster.sd_setImage(with: url)
        }
    }
    
    // favourite button setup
    private func setupFavouriteButton() {
        favouriteButton.isSelected = viewModel.isFavorite(movie: movie)
        updateFavouriteButtonImage()
    }
}

//MARK: - Handle favourite button logic
extension MovieDetailsVC {
    private func updateFavouriteButtonState() {
        viewModel.toggleFavorite(for: movie)
        favouriteButton.isSelected = viewModel.isFavorite(movie: movie)
        updateFavouriteButtonImage()
    }
    
    private func updateFavouriteButtonImage() {
        let imageName = favouriteButton.isSelected ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)
        favouriteButton.setImage(image, for: .normal)
        favouriteButton.tintColor = .red
    }
}
