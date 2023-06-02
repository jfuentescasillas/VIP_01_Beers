//
//  BeersWorker.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 01/06/23.
//


import Foundation


// MARK: - Orders store API
protocol BeersStoreProtocol {
	// MARK: CRUD operations - Optional error
	//func fetchBeers(completionHandler: @escaping (() throws -> [BeerModel]) -> Void)
	func fetchBeers(withPaginationNumber: Int, _ completion: @escaping (Result<[BeerModel], ApiError>) -> ())
}


// MARK: - Class. BeersWorker
class BeersWorker: BeersStoreProtocol {
	/*var beersStore: BeersStoreProtocol
	
	
	init(beersStore: BeersStoreProtocol) {
		self.beersStore = beersStore
	}*/
	
	
	/*func fetchBeers(completionHandler: @escaping ([BeerModel]) -> Void) {
		beersStore.fetchBeers { (beers: () throws -> [BeerModel]) -> Void in
			do {
				let beers = try beers()
				
				DispatchQueue.main.async {
					completionHandler(beers)
				}
			} catch {
				DispatchQueue.main.async {
					completionHandler([])
				}
			}
		}
	}*/
	
	
	func fetchBeers(withPaginationNumber: Int, _ completion: @escaping (Result<[BeerModel], ApiError>) -> ()) {
		let beerUrl: String = "https://api.punkapi.com/v2/beers?page=\(withPaginationNumber)&per_page=80"
		
		guard let url = URL(string: beerUrl) else {
			completion(.failure(.apiError(reason: "Invalid URL")))
			
			return
		}
		
		let request = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: request) { (beerData, beerResponse, beerError) in
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
		
		task.resume()
	}
}
