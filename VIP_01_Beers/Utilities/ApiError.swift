//
//  ApiError.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 01/06/23.
//


import Foundation


// MARK: - Error Manager
enum ApiError: Error, LocalizedError {
	case unknownError
	case noInternetConnection
	case badUrl
	case generic(Error?)
	case clientError(reason: String)
	case serverError(reason: String)
	case apiError(reason: String)
	
	var errorDescription: String? {
		switch self {
		case .unknownError:
			return "Unknown Error"
			
		case .noInternetConnection:
			return "Device With No Internet Connection"
			
		case .badUrl:
			return "Invalid API URL. Please provide a valid URL"
			
		case .generic(let error):
			return error?.localizedDescription ?? "Generic error"
			
		case .clientError(let error),
				.serverError(let error),
				.apiError(let error):
			return error
		}
	}
}
