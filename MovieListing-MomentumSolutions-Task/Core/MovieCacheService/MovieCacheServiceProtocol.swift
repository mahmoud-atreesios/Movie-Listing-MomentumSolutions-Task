//
//  MovieCacheServiceProtocol.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 23/07/2025.
//

import Foundation

protocol MovieCacheServiceProtocol {
    func saveMovies(_ movies: [Movie])
    func loadMovies() -> [Movie]?
}
