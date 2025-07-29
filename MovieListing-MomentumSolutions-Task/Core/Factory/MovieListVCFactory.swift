//
//  MovieListVCFactory.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import UIKit

enum MovieListVCFactory {
    static func make() -> MovieListVC {
        let networkProvider = NetworkProvider()
        let remoteDS = FetchPopularMoviesRemoteDS(networkProvider: networkProvider)
        let repo = FetchPopularMoviesRepo(fetchPopularMoviesRemoteDS: remoteDS)
        let cacheService = MovieCacheService()
        let favoriteService = FavoriteService()
        let fetchPopularMoviesUsecase = FetchPopularMoviesUsecase(fetchPopularMoviesRepo: repo, cacheService: cacheService, favoriteService: favoriteService)
        let toggleFavouriteUsecase = ToggleFavoriteUseCase(favoriteService: favoriteService)
        let viewModel = MovieListViewModel(fetchPopularMovie: fetchPopularMoviesUsecase, toggleFavoriteUseCase: toggleFavouriteUsecase)
        let vc = MovieListVC(viewModel: viewModel)
        return vc
    }
}
