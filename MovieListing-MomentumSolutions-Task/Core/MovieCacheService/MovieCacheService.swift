//
//  MovieCacheService.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 23/07/2025.
//

import Foundation

class MovieCacheService: MovieCacheServiceProtocol {
    private let fileName = "cached_movies.json"
    
    private var cacheURL: URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }
    
    func saveMovies(_ movies: [Movie]) {
        guard let url = cacheURL else { return }
        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: url)
        } catch {
            print("Error caching movies: \(error)")
        }
    }
    
    func loadMovies() -> [Movie]? {
        guard let url = cacheURL else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Movie].self, from: data)
        } catch {
            print("Error loading cached movies: \(error)")
            return nil
        }
    }
}
