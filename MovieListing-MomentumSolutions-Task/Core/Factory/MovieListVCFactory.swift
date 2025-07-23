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
        let useCase = FetchPopularMoviesUsecase(fetchPopularMoviesRepo: repo)
        let cacheService = MovieCacheService()
        let favoriteService = FavoriteService()
        let viewModel = MovieListViewModel(fetchPopularMovie: useCase, cacheService: cacheService, favoriteService: favoriteService)
        let vc = MovieListVC(viewModel: viewModel)
        return vc
    }
}
