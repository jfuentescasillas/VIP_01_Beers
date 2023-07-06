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
	case badResponse
	case noInternetConnection
	case badUrl
	case generic(Error?)
	case clientError(reason: String)
	case serverError(reason: String)
	case apiError(reason: String)
	
	var errorDescription: String? {
		switch self {
		case .unknownError:
            return "unknownError".localized
			
		case .badResponse:
            return "unknownResponse".localized
			
		case .noInternetConnection:
            return "noInternetError".localized
			
		case .badUrl:
            return "badUrlError".localized
			
		case .generic(let error):
            return error?.localizedDescription ?? "genericError".localized
			
		case .clientError(let error),
				.serverError(let error),
				.apiError(let error):
			return error
		}
	}
}
