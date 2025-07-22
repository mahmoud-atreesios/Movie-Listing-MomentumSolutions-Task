//
//  FetchPopularMoviesRepo.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

class FetchPopularMoviesRepo: FetchPopularMoviesRepoProtocol {
    private var fetchPopularMoviesRemoteDS: FetchPopularMoviesRemoteDSProtocol
    
    init(fetchPopularMoviesRemoteDS: FetchPopularMoviesRemoteDSProtocol) {
        self.fetchPopularMoviesRemoteDS = fetchPopularMoviesRemoteDS
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], AppException>) -> Void) {
        fetchPopularMoviesRemoteDS.fetchPopularMovies { result in
            switch result {
            case .success(let popularMoviesDto):
                let movies = popularMoviesDto.results.map { $0.toDomain() }
                completion(.success(movies))
            case .failure(let appException):
                completion(.failure(appException))
            }
        }
    }
}
