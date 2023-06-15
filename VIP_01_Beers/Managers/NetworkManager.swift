//
//  NetworkManager.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 14/06/23.
//


/*
 import UIKit


class NetworkManager {
	static let shared 			= NetworkManager()
	private let baseURL: String = "https://api.github.com/users/"
	let cache 					= NSCache<NSString, UIImage>()
	let decoder 				= JSONDecoder()
	
	private init() {
		decoder.keyDecodingStrategy  = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
	}
	
	// Async-Await
	func fetchBeers(withPaginationNumber: Int) async throws -> [BeerModel] {
		// let beerUrl: String = "https://api.punkapi.com/v2/beers?page=\(withPaginationNumber)&per_page=80"
		let beerModel  = BeerFetchModel(page: String(withPaginationNumber))
		let requestURL = BeerRequestModel(model: beerModel)
		
		guard let url = URL(string: requestURL.endpoint) else {
			throw ApiError.badUrl
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse else {
			throw ApiError.unknownError
		}
		
		switch response.statusCode {
		case 200...299:
			// Success case (2xx status codes)
			do {
				let beers = try decoder.decode([BeerModel].self, from: data)
				
				return beers
			} catch let errorDecodingBeers {
				print("Beers could not be decoded: \(String(describing: errorDecodingBeers.localizedDescription))")

				throw ApiError.generic(errorDecodingBeers)
			}
			
		case 400...499:
			// Client error case (4xx status codes)
			throw ApiError.clientError(reason: "\(response.statusCode)")

		case 500...599:
			// Server error case (5xx status codes)
			throw ApiError.serverError(reason: "\(response.statusCode)")
		
		default:
			throw ApiError.unknownError
		}
	}
}
*/
