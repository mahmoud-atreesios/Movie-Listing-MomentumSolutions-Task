//
//  FetchPopularMoviesRemoteDSProtocol.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

protocol FetchPopularMoviesRemoteDSProtocol {
    func fetchPopularMovies(completion: @escaping (Result<PopularMoviesDTO, AppException>) -> Void)
}
