//
//  MovieListViewModel.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import UIKit
import Combine

class MovieListViewModel {
    private let fetchPopularMovie: FetchPopularMoviesUsecaseProtocol
    private let cacheService: MovieCacheServiceProtocol
    private let favoriteService: FavoriteServiceProtocol
    
    private var cancellables = Set<AnyCancellable>()

    @Published var movies: [Movie] = []
    @Published var error: AppException?
    
    
    //MARK: - Initialization
    init(
        fetchPopularMovie: FetchPopularMoviesUsecaseProtocol,
        cacheService: MovieCacheServiceProtocol,
        favoriteService: FavoriteServiceProtocol
    ) {
        self.fetchPopularMovie = fetchPopularMovie
        self.cacheService = cacheService
        self.favoriteService = favoriteService
    }
}

//MARK: - Fetch Movies
extension MovieListViewModel {
    func fetchMovies() {
        fetchPopularMovie.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }

                switch result {
                case .success(let movies):
                    let favoriteIDs = self.favoriteService.loadFavorites()
                    let updatedMovies = movies.map { movie in
                        var copy = movie
                        copy.isFavorite = favoriteIDs.contains(movie.id)
                        return copy
                    }
                    self.movies = updatedMovies
                    self.cacheService.saveMovies(updatedMovies)
                    
                case .failure(let error):
                    if let cached = self.cacheService.loadMovies() {
                        self.movies = cached
                    } else {
                        self.error = error
                    }
                }
            }
        }
    }
}

//MARK: - Handle is favourite logic
extension MovieListViewModel {
    func toggleFavorite(for movie: Movie) {
        guard let index = movies.firstIndex(where: { $0.id == movie.id }) else { return }
        movies[index].isFavorite.toggle()
        
        let favoriteIDs = movies.filter { $0.isFavorite }.map { $0.id }
        favoriteService.saveFavorites(ids: favoriteIDs)
    }

    func isFavorite(movie: Movie) -> Bool {
        return movies.first(where: { $0.id == movie.id })?.isFavorite ?? false
    }
}
