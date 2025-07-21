//
//  AppException.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//


import Foundation

enum AppException: Error {
    case validationErorr(ValidationError)
    case networkError(NetworkError)
    case dataStorageError(DataStorageError)
    case unknownError
}

//MARK: - Network Error
extension AppException {
    enum NetworkError: Error {
        case userInactive
        case networkError
        case googleSignInCancelled
        case invalidURL
        case noDataFound
        case invalidResponse
        case failedToDecode
        case failedToEncode
        case invalidBody
        case invalidModelDto
        case badRequest
        case forbiddenAccess
        case resourceNotFound
        case internalServerError
        case badGateway
        case serviceUnavailable
        case unknownStatusCodeError
        case failedRequest
        case failedToBuildRequest
        case notConnectedToInternet
        case cannotFindHost
        case cannotConnectToHost
    }
}

//MARK: - Data Storage Error
extension AppException {
    enum DataStorageError: Error {
        case failedToSaveData
        case failedToRetrieveData
        case failedToUpdateData
        case failedToDeleteData
        case presistentContainer
        case noDataInLocalStorage
        case failedNewObjectInsertion
    }
}

//MARK: - Validation Error
extension AppException {
    enum ValidationError: Error {
        case invalidEmail
        case invalidPhoneNumber
        case invalidPassword
        case invalidCredentials
        case invalidUsername
    }
}

//MARK: - Error description
extension AppException {
    var errorDescription: String? {
        switch self {
            //MARK: - Validation error
        case .validationErorr(let error):
            switch error {
            case .invalidEmail:
                return "Sorry! Invalid Email"
            case .invalidPhoneNumber:
                return "Sorry! Invalid Phone Number"
            case .invalidPassword:
                return "Sorry! Invalid Password"
            case .invalidCredentials:
                return "The credntials is incorrect."
            case .invalidUsername:
                return "Sorry! Invalid username"
            }
            
            //MARK: - Network Error
        case .networkError(let error):
            switch error {
            case .userInactive:
                return "The account is inactive. Please contact support."
            case .networkError:
                return "Network error occurred. Please try again later."
            case .googleSignInCancelled:
                return "Google sign-in was cancelled."
            case .invalidURL:
                return "Invalid URL"
            case .noDataFound:
                return "No data found."
            case .invalidResponse:
                return "Invalid response from the server."
            case .failedToDecode:
                return "Failed to Decode response"
            case .failedToEncode:
                return "Failed to encode request body"
            case .invalidBody:
                return "Invalid body the body is not of type codable"
            case .invalidModelDto:
                return "Invalid model dto the model is not of type codable"
            case .badRequest:
                return "Failed: bad request"
            case .forbiddenAccess:
                return "Failed: for bidden access"
            case .resourceNotFound:
                return "Failed: resource not found"
            case .internalServerError:
                return "Failed: internal server error"
            case .badGateway:
                return "Failed: bad gateway"
            case .serviceUnavailable:
                return "Failed: service is un available"
            case .unknownStatusCodeError:
                return "Failed: unknown status code error"
            case .failedRequest:
                return "Failed to build or perform the request"
            case .failedToBuildRequest:
                return "Failed to build the request because the request is equal to nil"
            case .notConnectedToInternet:
                return "Not connected to internet."
            case .cannotFindHost:
                return "Cannot find the host."
            case .cannotConnectToHost:
                return "Cannot connect to the host."
            }
            
            //MARK: - Storage error
        case .dataStorageError(let error):
            switch error {
            case .failedToSaveData:
                return "Failed to save data."
            case .failedToRetrieveData:
                return "Failed to retrieve data."
            case .failedToUpdateData:
                return "Failed to update data."
            case .failedToDeleteData:
                return "Failed to delete data."
                
            case .presistentContainer:
                return "Failed to load Core Data stack"
            case .noDataInLocalStorage:
                return "Data storage is empty."
            case .failedNewObjectInsertion:
                return "Couldn't insert new object in the entity"
            }
        case .unknownError:
            return "Unkown Error"
        }
    }
}
