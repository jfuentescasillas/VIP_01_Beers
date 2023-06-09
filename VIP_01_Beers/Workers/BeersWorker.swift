//
//  BeersWorker.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 01/06/23.
//


import Foundation
import Combine


// MARK: - Orders store API
protocol BeersStoreProtocol {
	// MARK: Fetch beers using URLSession. It Works
	// func fetchBeers(withPaginationNumber: Int, _ completion: @escaping (Result<[BeerModel], ApiError>) -> ())
	
	// MARK: Fetch beers using Combine version 1. It Works
	func fetchCharactersFromAPIBusiness(withPagination: Int, success: @escaping([BeerModel]?) -> Void, failure: @escaping(ApiError?) -> Void)
	
	// TODO: fetch beers using Combine version 2
	// func fetchBeers(withPagination: Int) -> AnyPublisher<[BeerModel], ApiError>
}


// MARK: - Class. BeersWorker
class BeersWorker: BeersStoreProtocol {
	private var cancellable = Set<AnyCancellable>()
	
	// MARK: Fetch Beers using URLSession. It Works
	/* func fetchBeers(withPaginationNumber: Int, _ completion: @escaping (Result<[BeerModel], ApiError>) -> ()) {
		let beerUrl: String = "https://api.punkapi.com/v2/beers?page=\(withPaginationNumber)&per_page=80"
		
		guard let url = URL(string: beerUrl) else {
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
			
			// Conection is valid
			if beerResponse.statusCode == 200 {
				do {
					let beersDecoder = try JSONDecoder().decode([BeerModel].self, from: beerData)
					completion(.success(beersDecoder))
				} catch let errorDecodingBeers {
					print("File could not be parsed: \(String(describing: beerError?.localizedDescription))")
					
					completion(.failure(.generic(errorDecodingBeers)))
				}
			} else {
				fatalError("Error in statuscode (getting Beers): \(beerResponse.statusCode)")
			}
		}
		
		dataTask.resume()
	} */
	
	
	// MARK: Fetch Beers Using Combine Version 1. It Works
	internal func fetchCharactersFromAPIBusiness(withPagination: Int,
												 success: @escaping([BeerModel]?) -> Void,
												 failure: @escaping(ApiError?) -> Void) {
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
		let beerModel = BeerFetchModel(page: String(withPagination))
		let request   = BeerRequestModel(model: beerModel)
		
		// Call method inspired from the other app's Request Manager
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
							ApiError.internalError(reason: "\(httpResponse.statusCode)")
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
	}
	
	
	// TODO: Fetch Beers Using Combine Version 2
	/* internal func fetchBeers(withPagination: Int) -> AnyPublisher<[BeerModel], ApiError> {
		let beerModel = BeerFetchModel(page: String(withPagination))
		let request = BeerRequestModel(model: beerModel)
		
		let beersFetched = fetchRequestBeers(request: request, entityClass: [BeerModel.self])
			.map { response in
				// print("Response to get the trailer url (Inside Movie Details Provider): ")
				// print("\(response)")
				// print("----------------------------------------------\n")
				
				return Just(response)
					.setFailureType(to: ApiError.self)
					.eraseToAnyPublisher()
			}.switchToLatest()
			.eraseToAnyPublisher()
		
		return beersFetched
	}
	
	
	private func fetchRequestBeers<R: Request, T: Decodable>(request: R, entityClass: [T.Type]) -> AnyPublisher<T, ApiError> {
		let endpoint = request.endpoint
		
		guard let url = URL(string: endpoint) else {
			return Fail(error: ApiError.badUrl).eraseToAnyPublisher()
		}
		
		let data = try? JSONSerialization.data(withJSONObject: request.params, options: .prettyPrinted)  // Para pasarlo al body
		let defaultSessionConfig = URLSessionConfiguration.default  // Objeto urlrequest por defecto
		defaultSessionConfig.httpAdditionalHeaders = request.httpHeaders
		
		let defaultSession = URLSession(configuration: defaultSessionConfig)
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.httpMethod.rawValue
		
		print("request.httpMethod: \(request.httpMethod)")
		
		if request.httpMethod == .post {
			urlRequest.httpBody = data
		}  // Hasta aquí sería una petición POST clásica porque pasamos los datos por el body de la petición
		
		return defaultSession
			.dataTaskPublisher(for: urlRequest)
			.mapError { error -> ApiError in
				ApiError.unknownError
			}
			.flatMap { data, response -> AnyPublisher<T, ApiError> in
				guard let httpResponse = response as? HTTPURLResponse else {
					return Fail(error: ApiError.unknownError).eraseToAnyPublisher()
				}
				
				if (200...299).contains(httpResponse.statusCode) {
					return Just(data).decode(type: T.self, decoder: JSONDecoder())
						.mapError { error in
							ApiError.unknownError
						}
						.eraseToAnyPublisher()
				} else {
					let error = ApiError.unknownError
					
					return Fail(error: error).eraseToAnyPublisher()
				}
			}
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()  // Release of callback sequence
	} */
}
