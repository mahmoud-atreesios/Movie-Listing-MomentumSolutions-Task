//
//  FetchPopularMoviesUsecase.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

class FetchPopularMoviesUsecase: FetchPopularMoviesUsecaseProtocol {
    private let fetchPopularMoviesRepo: FetchPopularMoviesRepoProtocol
    private let cacheService: MovieCacheServiceProtocol
    private let favoriteService: FavoriteServiceProtocol
    
    init(fetchPopularMoviesRepo: FetchPopularMoviesRepoProtocol,cacheService: MovieCacheServiceProtocol,favoriteService: FavoriteServiceProtocol) {
        self.fetchPopularMoviesRepo = fetchPopularMoviesRepo
        self.cacheService = cacheService
        self.favoriteService = favoriteService
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], AppException>) -> Void) {
        fetchPopularMoviesRepo.fetchPopularMovies{ [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                let favoriteIDs = self.favoriteService.loadFavorites()
                let updatedMovies = movies.map { movie in
                    var copy = movie
                    copy.isFavorite = favoriteIDs.contains(movie.id)
                    return copy
                }
                self.cacheService.saveMovies(updatedMovies)
                completion(.success(updatedMovies))
                
            case .failure(let error):
                if let cached = self.cacheService.loadMovies() {
                    completion(.success(cached))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
