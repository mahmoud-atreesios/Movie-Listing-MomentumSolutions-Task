//
//  AsyncRequestBuilder.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//


import Foundation

//MARK: - Requst builder is responsible for constructing url request
class RequestBuilder: RequestBuilderProtocol {
    private let encoder = JSONEncoder()
    //var request: URLRequest?
}

//MARK: - Request function (take endpoint and return request) ✅
extension RequestBuilder {
    func buildRequest(apiEndpoint: EndpointProtocol, method: HTTPMethod) throws -> URLRequest {
        
        //MARK: - construct url component
        var urlComponents = try constructUrlComponent(apiEndpoint: apiEndpoint)
        
        //MARK: - add parameter
        addQueryParameter(apiEndpoint.queryParameters, urlComponents: &urlComponents)
        
        //MARK: - validate url
        let url = try validateURL(urlComponents: urlComponents)
        
        //MARK: - build request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        //MARK: - add headers
        addHeaders(request: &request, headers: apiEndpoint.headers)
        
        //MARK: - encode body if there is one
        if isMethodNeedBody(method: method) {
            if let body = apiEndpoint.body {
                do {
                    request.httpBody = try encoder.encode(body)
                } catch {
                    throw AppException.networkError(.failedToEncode)
                }
            }
        }
        return request
    }
}

//MARK: - Construct url component function
extension RequestBuilder {
    private func constructUrlComponent(apiEndpoint: EndpointProtocol) throws -> URLComponents {
        guard let urlComponents = URLComponents(string: apiEndpoint.baseURL + apiEndpoint.path) else {
            throw AppException.networkError(.invalidURL)
        }
        return urlComponents
    }
}

//MARK: - Validate url function
extension RequestBuilder {
    private func validateURL(urlComponents: URLComponents) throws -> URL {
        guard let url = urlComponents.url else {
            throw AppException.networkError(.invalidURL)
        }
        return url
    }
}

//MARK: - Adding query parameter function
extension RequestBuilder {
    private func addQueryParameter(_ queryParameter: [String:String]?, urlComponents: inout URLComponents) {
        if let queryParameter = queryParameter {
            urlComponents.queryItems = queryParameter.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
    }
}

//MARK: - AddHeaders
extension RequestBuilder {
    private func addHeaders(request: inout URLRequest, headers: [String: String]?) {
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

//MARK: - Check method that need body
extension RequestBuilder {
   private func isMethodNeedBody(method: HTTPMethod) -> Bool {
        switch method {
        case .post, .put:
            return true
        default:
            return false
        }
    }
}
