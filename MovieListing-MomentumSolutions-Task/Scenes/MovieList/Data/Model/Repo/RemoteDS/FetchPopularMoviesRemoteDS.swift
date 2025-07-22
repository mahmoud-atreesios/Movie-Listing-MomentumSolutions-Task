//
//  FetchPopularMoviesRemoteDS.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

class FetchPopularMoviesRemoteDS {
    private var networkProvider: NetworkProviderProtocol
    
    init(networkProvider: NetworkProviderProtocol) {
        self.networkProvider = networkProvider
    }
    
    func fetchPopularMovies(completion: @escaping (Result<PopularMoviesDTO, AppException>) -> Void) {
        networkProvider.get(apiEndpoint: FetchPopularMoviesRequest(), modelDto: PopularMoviesDTO.self, completion: completion)
    }
    
}
