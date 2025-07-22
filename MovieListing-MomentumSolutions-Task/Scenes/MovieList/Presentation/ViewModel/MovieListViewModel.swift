//
//  MovieListViewModel.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation
import Combine

class MovieListViewModel {
    private let fetchPopularMovie: FetchPopularMoviesUsecaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var movies: [Movie] = []
    @Published var error: AppException?

    init(fetchPopularMovie: FetchPopularMoviesUsecaseProtocol) {
        self.fetchPopularMovie = fetchPopularMovie
    }
    
    func fetchMovies() {
        fetchPopularMovie.fetchPopularMovies { [weak self] result in
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
