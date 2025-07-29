//
//  ToggleFavoriteUseCaseProtocol.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Omar AbdElrazek on 29/07/2025.
//

import Foundation

protocol ToggleFavoriteUseCaseProtocol {
    func toggle(movie: Movie, in list: [Movie]) -> [Movie]
}
