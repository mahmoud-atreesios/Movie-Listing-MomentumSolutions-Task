//
//  MoviesMapper.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

extension MovieDTO {
    func toDomain() -> Movie {
        return Movie(
            id: id ?? 0,
            poster: posterPath ?? "no data found",
            title: title ?? "no data found",
            voteAverage: voteAverage ?? 0.0,
            releaseDate: releaseDate ?? "no data found",
            originalLanguage: originalLanguage ?? "no data found",
            overview: overview ?? "no data found"
        )
    }
}
