//
//  MockCacheService.swift
//  MovieListing-MomentumSolutions-TaskTests
//
//  Created by Mahmoud Mohamed Atrees on 23/07/2025.
//

import Foundation
@testable import MovieListing_MomentumSolutions_Task

class MockCacheService: MovieCacheServiceProtocol {
    func saveMovies(_ movies: [Movie]) {}
    func loadMovies() -> [Movie]? { return nil }
}
