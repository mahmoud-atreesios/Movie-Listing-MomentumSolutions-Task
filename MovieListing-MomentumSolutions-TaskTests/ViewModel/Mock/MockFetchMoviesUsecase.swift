//
//  MockFetchMoviesUsecase.swift
//  MovieListing-MomentumSolutions-TaskTests
//
//  Created by Mahmoud Mohamed Atrees on 23/07/2025.
//

import Foundation
@testable import MovieListing_MomentumSolutions_Task

class MockFetchMoviesUsecase: FetchPopularMoviesUsecaseProtocol {
    private let result: Result<[Movie], AppException>

    init(result: Result<[Movie], AppException>) {
        self.result = result
    }

    func fetchPopularMovies(completion: @escaping (Result<[Movie], AppException>) -> Void) {
        completion(result)
    }
}
