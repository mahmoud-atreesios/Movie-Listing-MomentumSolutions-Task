//
//  Movie.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let poster: String
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let originalLanguage: String
    let overview: String
    var isFavorite: Bool = false 
}
