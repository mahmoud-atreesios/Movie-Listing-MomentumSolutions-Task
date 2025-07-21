//
//  ApiClient.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//


import Foundation

//MARK: - Responisble for perfom request after the request has been built
class ApiClient: ApiClientProtocol {
    private let responseHandler = ResponseHandler()
    private let solutionXExceptionMapper = SolutionXExceptionMapper()
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
}

//MARK: - Send request
extension ApiClient {
    func sendRequest<T: Codable>(endpoint: EndpointProtocol, request: inout URLRequest, modelDto: T.Type, completion: @escaping (Result<T, AppException>) -> Void) {
        responseHandler.addHeaders(request: &request, headers: endpoint.headers)
        self.performRequest(request: request, modelDto: modelDto, completion: completion)
    }
}

//MARK: - Perfom request funtion
extension ApiClient {
    private func performRequest<T: Codable>(
        request: URLRequest,
        modelDto: T.Type,
        completion: @escaping (Result<T, AppException>) -> Void){
            let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    let mappedError = self.solutionXExceptionMapper.map(error: error)
                    completion(.failure(mappedError))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.networkError(.noDataFound)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.networkError(.invalidResponse)))
                    return
                }
                self.responseHandler.handleResponseStatusCode(statusCode: httpResponse.statusCode, data: data, modelDto: modelDto, completion: completion)
            }
            task.resume()
        }
}
