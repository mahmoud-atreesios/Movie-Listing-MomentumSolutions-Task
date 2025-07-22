//
//  FetchPopularMoviesRepoProtocol.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

protocol FetchPopularMoviesRepoProtocol {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], AppException>) -> Void)
}
