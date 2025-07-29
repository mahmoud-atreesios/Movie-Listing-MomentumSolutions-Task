//
//  MovieListViewModel.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import UIKit
import Combine

class MovieListViewModel {
    private let fetchPopularMovieUsecase: FetchPopularMoviesUsecaseProtocol
    private let toggleFavoriteUseCase: ToggleFavoriteUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    @Published var movies: [Movie] = []
    @Published var error: AppException?
    
    
    //MARK: - Initialization
    init(fetchPopularMovie: FetchPopularMoviesUsecaseProtocol,toggleFavoriteUseCase: ToggleFavoriteUseCaseProtocol) {
        self.fetchPopularMovieUsecase = fetchPopularMovie
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
    }
}

//MARK: - Fetch Movies
extension MovieListViewModel {
    func fetchMovies() {
        fetchPopularMovieUsecase.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}

//MARK: - Handle is UI favourite logic
extension MovieListViewModel {
    func toggleFavorite(for movie: Movie) {
        movies = toggleFavoriteUseCase.toggle(movie: movie, in: movies)
    }
    func isFavorite(movie: Movie) -> Bool {
        movies.first(where: { $0.id == movie.id })?.isFavorite ?? false
    }
}
