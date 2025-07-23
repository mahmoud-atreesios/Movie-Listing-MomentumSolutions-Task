//
//  MockFavoriteService.swift
//  MovieListing-MomentumSolutions-TaskTests
//
//  Created by Mahmoud Mohamed Atrees on 23/07/2025.
//

import Foundation
@testable import MovieListing_MomentumSolutions_Task

class MockFavoriteService: FavoriteServiceProtocol {
    func saveFavorites(ids: [Int]) {}
    func loadFavorites() -> Set<Int> { return [] }
}
