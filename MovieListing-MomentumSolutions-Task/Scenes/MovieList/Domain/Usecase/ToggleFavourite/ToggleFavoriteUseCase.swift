//
//  ToggleFavoriteUseCase.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Omar AbdElrazek on 29/07/2025.
//

import Foundation

class ToggleFavoriteUseCase: ToggleFavoriteUseCaseProtocol {
    private let favoriteService: FavoriteServiceProtocol

    init(favoriteService: FavoriteServiceProtocol) {
        self.favoriteService = favoriteService
    }

    func toggle(movie: Movie, in list: [Movie]) -> [Movie] {
        var updatedList = list
        if let index = updatedList.firstIndex(where: { $0.id == movie.id }) {
            updatedList[index].isFavorite.toggle()
        }

        let favoriteIDs = updatedList.filter { $0.isFavorite }.map { $0.id }
        favoriteService.saveFavorites(ids: favoriteIDs)

        return updatedList
    }
}
