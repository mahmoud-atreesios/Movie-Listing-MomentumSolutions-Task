//
//  EndpointProtocol.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//


import Foundation

protocol EndpointProtocol {
    var baseURL: String { get set }
    var path: String { get set }
    var headers: [String: String]? { get set }
    var body: Codable? { get set }
    var queryParameters: [String: String]? { get set }
}
