//
//  MovieListViewModel.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import UIKit
import Combine

class MovieListViewModel {
    private let fetchPopularMovie: FetchPopularMoviesUsecaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private let cacheFileName = "cached_movies.json"
    private let favoritesKey = "favorite_movie_ids"

    @Published var movies: [Movie] = []
    @Published var error: AppException?
    
    private var cacheURL: URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(cacheFileName)
    }
    
    init(fetchPopularMovie: FetchPopularMoviesUsecaseProtocol) {
        self.fetchPopularMovie = fetchPopularMovie
    }
    
    private func cacheMovies(_ movies: [Movie]) {
        guard let url = cacheURL else { return }
        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: url)
        } catch {
            print("Failed to cache movies: \(error)")
        }
    }
    
    private func loadCachedMovies() -> [Movie]? {
        guard let url = cacheURL else { return nil }
        do {
            let data = try Data(contentsOf: url)
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            return movies
        } catch {
            print("Failed to load cached movies: \(error)")
            return nil
        }
    }
    
    func fetchMovies() {
        fetchPopularMovie.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.cacheMovies(movies)
                case .failure(let error):
                    if let cached = self?.loadCachedMovies() {
                        self?.movies = cached
                    } else {
                        self?.error = error
                    }
                }
            }
        }
    }
}


//MARK: - Handle is favourite logic
extension MovieListViewModel {
    func toggleFavorite(for movie: Movie) {
        guard let index = movies.firstIndex(where: { $0.id == movie.id }) else { return }
        movies[index].isFavorite.toggle()
    }

    func isFavorite(movie: Movie) -> Bool {
        return movies.first(where: { $0.id == movie.id })?.isFavorite ?? false
    }
}
