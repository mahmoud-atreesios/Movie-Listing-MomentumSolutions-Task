//
//  MovieListing_MomentumSolutions_TaskTests.swift
//  MovieListing-MomentumSolutions-TaskTests
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//

import XCTest
import Combine
@testable import MovieListing_MomentumSolutions_Task

final class MovieListing_ViewModel_Tests: XCTestCase {
    
    private var mockUsecase: MockFetchMoviesUsecase!
    private var mockCache: MockCacheService!
    private var mockFavorites: MockFavoriteService!
    
    private var cancellables: Set<AnyCancellable> = []
    private let expectedMovies = [
        Movie(
            id: 111,
            poster: "posterString",
            title: "Then one man show",
            voteAverage: 7.9,
            releaseDate: "2015/09/16",
            originalLanguage: "en",
            overview: "One of the greates Movies I have ever watched")
    ]
    
    //MARK: - Test Fail
    func skip_test_Fail() {
        XCTFail("Ensure that the system fails")
    }
    
    //MARK: - Setup
    override func setUp() {
        mockUsecase = MockFetchMoviesUsecase(result: .success(expectedMovies))
        mockCache = MockCacheService()
        mockFavorites = MockFavoriteService()
    }
    
    //MARK: - TearDown
    override func tearDown() {
        mockUsecase = nil
        mockCache = nil
        mockFavorites = nil
        cancellables.removeAll()
    }
    
    //MARK: - Test Fetch Movies Function in MovieListViewModel
    func test_movieListViewModel_whenRecievedMovies_ShouldPublishMovies() {
        // Arrange
        let sut = MovieListViewModel(
            fetchPopularMovie: mockUsecase,
            cacheService: mockCache,
            favoriteService: mockFavorites
        )
        
        let expectation = XCTestExpectation(description: "Movies published")
        
        // Act
        sut.$movies
            .dropFirst()
            .sink { movies in
                
                // Assert
                XCTAssertEqual(movies.count, self.expectedMovies.count)
                XCTAssertEqual(movies.map { $0.id }, self.expectedMovies.map { $0.id })
                XCTAssertEqual(movies.map { $0.title }, self.expectedMovies.map { $0.title })
                XCTAssertEqual(movies.map { $0.poster }, self.expectedMovies.map { $0.poster })

                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchMovies()
        
        wait(for: [expectation], timeout: 2.0)
    }
}
