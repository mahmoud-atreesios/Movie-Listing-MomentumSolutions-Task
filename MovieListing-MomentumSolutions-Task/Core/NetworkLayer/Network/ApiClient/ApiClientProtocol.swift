//
//  ApiClientProtocol.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//


import Foundation

protocol ApiClientProtocol {
    func sendRequest<T: Codable>(endpoint: EndpointProtocol, request: inout URLRequest, modelDto: T.Type, completion: @escaping (Result<T, AppException>) -> Void)
}
