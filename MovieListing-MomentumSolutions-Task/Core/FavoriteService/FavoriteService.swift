//
//  FavoriteService.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 23/07/2025.
//

import Foundation

class FavoriteService: FavoriteServiceProtocol {
    private let favoritesKey = "favorite_movie_ids"

    func saveFavorites(ids: [Int]) {
        UserDefaults.standard.set(ids, forKey: favoritesKey)
    }

    func loadFavorites() -> Set<Int> {
        let ids = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        return Set(ids)
    }
}
