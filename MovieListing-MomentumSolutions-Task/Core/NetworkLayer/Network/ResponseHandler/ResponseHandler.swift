//
//  ResponseHandler.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//


import Foundation

//MARK: - responsible for handling api responses
struct ResponseHandler {
    private let decoder = JSONDecoder()
}

//MARK: - AddHeaders
extension ResponseHandler {
    func addHeaders(request: inout URLRequest, headers: [String: String]?) {
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

//MARK: - Handle status code
extension ResponseHandler {
     func handleResponseStatusCode<T: Codable>(
        statusCode: Int,
        data: Data,
        modelDto: T.Type,
        completion: @escaping (Result<T, AppException>) -> Void) {
            switch statusCode {
            case 200...299:
                decodeData(data: data, modelDto: modelDto, completion: completion)
            default:
                if let error = errorDescription(code: statusCode) {
                    completion(.failure(error))
                }
            }
        }
}

//MARK: - decode data function
extension ResponseHandler {
    func decodeData<T: Codable>(data: Data, modelDto: T.Type, completion: @escaping (Result<T, AppException>) -> Void) {
        do {
            let decodedData = try decoder.decode(modelDto, from: data)
            completion(.success(decodedData))
        } catch {
            print(error.localizedDescription)
            completion(.failure(.networkError(.failedToDecode)))
        }
    }
}

//MARK: - status code error cases
extension ResponseHandler {
    func errorDescription(code: Int) -> AppException? {
        switch code {
        case 400:
                .validationErorr(.invalidCredentials)
        case 403:
                .networkError(.forbiddenAccess)
        case 404:
                .networkError(.resourceNotFound)
        case 500:
                .networkError(.internalServerError)
        case 502:
                .networkError(.badGateway)
        case 503:
                .networkError(.serviceUnavailable)
        default:
                .networkError(.unknownStatusCodeError)
        }
    }
}
