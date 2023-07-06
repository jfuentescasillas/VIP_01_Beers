//
//  BeersWorker.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 01/06/23.
//


// fetchInitialURL: "https://api.punkapi.com/v2/beers?page=1&per_page=80"


import Foundation
// import Combine  // Uncomment when using the Methodology with Combine


// MARK: - Orders store API
protocol BeersStoreProtocol {
	// MARK: Fetch beers using URLSession. It Works
	// func fetchBeers(withPaginationNumber: Int, _ completion: @escaping (Result<[BeerModel], ApiError>) -> ())
	
	// MARK: Fetch beers using Combine. It Works
	// func fetchBeersFromAPIBusiness(withPagination: Int, success: @escaping([BeerModel]?) -> Void, failure: @escaping(ApiError?) -> Void)
	
	// MARK: Fetch beers using Async-Await
	func fetchBeers(withPaginationNumber: Int) async throws -> [BeerModel]
}


// MARK: - Class. BeersWorker
class BeersWorker: BeersStoreProtocol {
	private let decoder = JSONDecoder()
	
	init() {
		decoder.keyDecodingStrategy  = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
	}
	// private var cancellable = Set<AnyCancellable>()  // Uncomment when using the Methodology with Combine
	
	// MARK: Fetch Beers using URLSession. It Works
	/* func fetchBeers(withPaginationNumber: Int, _ completion: @escaping (Result<[BeerModel], ApiError>) -> ()) {
	    // Error Simulator
		switch withPaginationNumber {
		case 400...499: // Simulate a client error (HTTP status code 400)
			let error = ApiError.clientError(reason: "\(withPaginationNumber)")
			completion(.failure(error))
			
			return
		case 500...599:	// Simulate a server error (HTTP status code 500)
			let error = ApiError.serverError(reason: "\(withPaginationNumber)")
			completion(.failure(error))
			
			return
		
		default:
			break
		}
		
		// let beerUrl: String = "https://api.punkapi.com/v2/beers?page=\(withPaginationNumber)&per_page=80"
		let beerModel  = BeerFetchModel(page: String(withPaginationNumber))
		let requestURL = BeerRequestModel(model: beerModel)
				
		guard let url = URL(string: requestURL.endpoint) else {
			completion(.failure(.apiError(reason: "Invalid URL")))
			
			return
		}
		
		let request = URLRequest(url: url)
		let dataTask = URLSession.shared.dataTask(with: request) { (beerData, beerResponse, beerError) in
			guard let beerData = beerData, beerError == nil, let beerResponse = beerResponse as? HTTPURLResponse else {
				print("Error in connection: \(String(describing: beerError))")
				
				completion(.failure(.generic(beerError)))
				
				return
			}
			
			// Check the status of the Response
			switch beerResponse.statusCode {
			case 200...299:
				print("All OK. Status Code: \(beerResponse.statusCode)")
				print("----------------------------------------------\n")
				
				do {
					let beersDecoder = try JSONDecoder().decode([BeerModel].self, from: beerData)
					completion(.success(beersDecoder))
				} catch let errorDecodingBeers {
					print("File could not be parsed: \(String(describing: beerError?.localizedDescription))")
					
					completion(.failure(.generic(errorDecodingBeers)))
				}
				
			case 400...499:
				print("Client error. Status Code: \(beerResponse.statusCode)")
				print("----------------------------------------------\n")
				completion(.failure(.clientError(reason: String(beerResponse.statusCode))))
				
			case 500...599:
				print("Server error. Status Code: \(beerResponse.statusCode)")
				print("----------------------------------------------\n")
				completion(.failure(.serverError(reason: String(beerResponse.statusCode))))
				
			default:
				let error = ApiError.unknownError
				print("Unknown error. Status Code: \(beerResponse.statusCode)")
				print("Error: \(error)")
				print("----------------------------------------------\n")
				completion(.failure(error))
			}
		}
		
		dataTask.resume()
	} */
	
	
	// MARK: Fetch Beers Using Combine. It Works
	/* internal func fetchBeersFromAPIBusiness(withPagination: Int, success: @escaping([BeerModel]?) -> Void, failure: @escaping(ApiError?) -> Void) {
		// Call method inspired from the other app's Provider
		fetchBeersList(withPagination: withPagination) { [weak self] (result) in
			guard self != nil else { return }
			
			switch result {
			case .success(let response):
				success(response)
				
			case .failure(let error):
				failure(error)
			}
		}
	}
	
	
	// Method inspired in the Provider class from the other app
	 private func fetchBeersList(withPagination: Int, completionHandler: @escaping (Result<[BeerModel], ApiError>) -> Void) {
		switch withPagination {
		// Simulate a client error (HTTP status code 400)
		case 400...499:
			let error = ApiError.clientError(reason: "\(withPagination)")
			completionHandler(.failure(error))
			
			return
			
		case 500...599:
		// Simulate a server error (HTTP status code 500)
			let error = ApiError.serverError(reason: "\(withPagination)")
			completionHandler(.failure(error))
			
			return
			
		default:
			break
		}
			
		// Call method inspired from the other app's Request Manager
		 let beerModel = BeerFetchModel(page: String(withPagination))
		 let request   = BeerRequestModel(model: beerModel)
				 
		 requestGeneric(request: request, entityClass: [BeerModel].self)
			.sink { [weak self] (completion) in
				guard self != nil else { return }
				
				switch completion {
				case .finished:
					break
					
				case .failure(let error):
					completionHandler(.failure(error))
				}
			} receiveValue: { [weak self] responseBeerModel in
				guard self != nil else { return }
				
				completionHandler(.success(responseBeerModel))
			}
			.store(in: &cancellable)
	}
	
	
	// Method inspired in the RequestManager class from the other app
	private func requestGeneric<R: Request, T: Decodable>(request: R, entityClass: T.Type) -> AnyPublisher<T, ApiError> {
		let endpoint = request.endpoint
		
		guard let url = URL(string: endpoint) else {
			let error = ApiError.unknownError
			
			return Fail(error: error).eraseToAnyPublisher()
		}
		
		let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url)
			.mapError { error -> ApiError in
				ApiError.unknownError
			}
			.flatMap { data, response -> AnyPublisher<T, ApiError> in
				guard let httpResponse = response as? HTTPURLResponse else {
					return Fail(error: ApiError.unknownError).eraseToAnyPublisher()
				}
				
				print("In the class BeersWorker.")
				
				switch httpResponse.statusCode {
				case 200...299:
					print("All OK. Status Code: \(httpResponse.statusCode)")
					print("----------------------------------------------\n")
					
					let justData = Just(data).decode(type: T.self, decoder: JSONDecoder())
						.mapError { error in
							ApiError.unknownError
						}
						.eraseToAnyPublisher()
					
					return justData
					
				case 400...499:
					print("Client error. Status Code: \(httpResponse.statusCode)")
					print("----------------------------------------------\n")
					
					let justData = Just(data).decode(type: T.self, decoder: JSONDecoder())
						.mapError { error in
							ApiError.clientError(reason: "\(httpResponse.statusCode)")
						}
						.eraseToAnyPublisher()
					
					return justData
					
				case 500...599:
					print("Server error. Status Code: \(httpResponse.statusCode)")
					print("----------------------------------------------\n")
					
					let justData = Just(data).decode(type: T.self, decoder: JSONDecoder())
						.mapError { error in
							ApiError.serverError(reason: "\(httpResponse.statusCode)")
						}
						.eraseToAnyPublisher()
					
					return justData
					
				default:
					let error = ApiError.unknownError
					
					return Fail(error: error).eraseToAnyPublisher()
				}
			}
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
		
		return dataTaskPublisher
	} */
	
	
	// MARK: Fetch Beers using Async-Await
	func fetchBeers(withPaginationNumber: Int) async throws -> [BeerModel] {
		// Error Simulator
		switch withPaginationNumber {
		case 400...499: // Simulate a client error (HTTP status code 400)
			let error = ApiError.clientError(reason: "\(withPaginationNumber)")
			throw error
			
		case 500...599:	// Simulate a server error (HTTP status code 500)
			let error = ApiError.serverError(reason: "\(withPaginationNumber)")
			throw error
			
		default:
			break
		}
		
		// let beerUrl: String = "https://api.punkapi.com/v2/beers?page=\(withPaginationNumber)&per_page=80"
		let beerModel  = BeerFetchModel(page: String(withPaginationNumber))
		let requestURL = BeerRequestModel(model: beerModel)
				
		guard let url = URL(string: requestURL.endpoint) else {
			throw ApiError.badUrl
		}
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse else {
			throw ApiError.badResponse
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
			throw ApiError.noInternetConnection
		}
	}
}
