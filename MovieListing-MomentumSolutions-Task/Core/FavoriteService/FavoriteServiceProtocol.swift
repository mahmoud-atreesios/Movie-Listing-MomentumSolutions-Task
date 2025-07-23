//
//  FavoriteServiceProtocol.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 23/07/2025.
//

import Foundation

protocol FavoriteServiceProtocol {
    func saveFavorites(ids: [Int])
    func loadFavorites() -> Set<Int>
}
