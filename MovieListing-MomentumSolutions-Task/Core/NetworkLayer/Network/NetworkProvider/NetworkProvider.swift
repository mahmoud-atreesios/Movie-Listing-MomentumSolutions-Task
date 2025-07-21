//
//  NetworkProvider.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//


import Foundation

class NetworkProvider: NetworkProviderProtocol {
    private var apiClient: ApiClientProtocol
    private let requestBuilder: RequestBuilderProtocol
    
    init(apiClient: ApiClientProtocol = ApiClient(), requestBuilder: RequestBuilderProtocol = RequestBuilder()) {
        self.apiClient = apiClient
        self.requestBuilder = requestBuilder
    }
}

//MARK: - GET function
extension NetworkProvider {
    func get<T: Codable>(apiEndpoint: EndpointProtocol, modelDto: T.Type, completion: @escaping (Result<T, AppException>) -> Void) {
        handleRequest(apiEndpoint: apiEndpoint, method: .get, modelDto: modelDto, completion: completion)
    }
}

//MARK: - POST function
extension NetworkProvider {
    func post<T: Codable>(apiEndpoint: EndpointProtocol, modelDto: T.Type, completion: @escaping (Result<T, AppException>) -> Void) {
        handleRequest(apiEndpoint: apiEndpoint, method: .post, modelDto: modelDto, completion: completion)
    }
}

// MARK: - PUT Function
extension NetworkProvider {
    func put<T: Codable>(apiEndpoint: EndpointProtocol, modelDto: T.Type, completion: @escaping (Result<T, AppException>) -> Void) {
        handleRequest(apiEndpoint: apiEndpoint, method: .put, modelDto: modelDto, completion: completion)
    }
}

// MARK: - DELETE Function
extension NetworkProvider {
    func delete<T: Codable>(apiEndpoint: EndpointProtocol, modelDto: T.Type, completion: @escaping (Result<T, AppException>) -> Void) {
        handleRequest(apiEndpoint: apiEndpoint, method: .delete, modelDto: modelDto, completion: completion)
    }
}

//MARK: - Common handle request process
extension NetworkProvider {
    private func handleRequest<T: Codable>(apiEndpoint: EndpointProtocol, method: HTTPMethod, modelDto: T.Type, completion: @escaping (Result<T, AppException>) -> Void) {
        do {
            var request = try requestBuilder.buildRequest(apiEndpoint: apiEndpoint, method: method)
            apiClient.sendRequest(endpoint: apiEndpoint, request: &request, modelDto: modelDto, completion: completion)
        } catch let error as AppException {
            completion(.failure(error))
        } catch {
            completion(.failure(.networkError(.unknownStatusCodeError)))
        }
    }
}
