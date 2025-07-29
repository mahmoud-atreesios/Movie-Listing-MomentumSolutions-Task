//
//  FetchPopularMoviesRequest.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 22/07/2025.
//

import Foundation

struct FetchPopularMoviesRequest: EndpointProtocol {
    var baseURL: String = "https://api.themoviedb.org/3/"
    var path: String = "movie/popular"
    
    var headers: [String: String]? = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNWE5OGQyMjhjNjNkNWIwYWY4MjFiNGI0ZTlmZTlkNSIsIm5iZiI6MTc1MzE4NzEzMi42OTcsInN1YiI6IjY4N2Y4MzNjZWU0Y2IwMWMzZmQ5OTZmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sdAByFuu53X44pQK2DP-_F6rIimWaNoieBuWD42Jxr8"
    ]
    
    var queryParameters: [String: String]? = [
        "language": "en-US",
        "page": "2"
    ]
     
    var body: (any Codable)? = nil
}

