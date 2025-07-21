//
//  RequestBuilder.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//


import Foundation

protocol RequestBuilderProtocol {
    func buildRequest(apiEndpoint: EndpointProtocol, method: HTTPMethod) throws -> URLRequest
}
