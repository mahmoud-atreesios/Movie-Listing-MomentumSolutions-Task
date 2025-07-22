//
//  FetchPopularMoviesUsecase.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

class FetchPopularMoviesUsecase: FetchPopularMoviesUsecaseProtocol {
    private let fetchPopularMoviesRepo: FetchPopularMoviesRepoProtocol
    
    init(fetchPopularMoviesRepo: FetchPopularMoviesRepoProtocol) {
        self.fetchPopularMoviesRepo = fetchPopularMoviesRepo
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], AppException>) -> Void) {
        fetchPopularMoviesRepo.fetchPopularMovies(completion: completion)
    }
}
