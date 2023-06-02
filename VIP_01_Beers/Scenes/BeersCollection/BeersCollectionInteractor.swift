//
//  BeersCollectionInteractor.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation


// MARK: - Protocols
protocol BeersCollectionBusinessLogic {
	func doLoadStaticData(request: BeersCollection.StaticData.Request)
	func fetchBeers(request: BeersCollection.FetchBeers.Request)
}


protocol BeersCollectionDataStore {
	var beersCollection: [BeerModel]? { get }
}


// MARK: - Class
class BeersCollectionInteractor: BeersCollectionDataStore {
	// MARK: - Properties
	var beersCollection: [BeerModel]?
	var presenter: BeersCollectionPresentationLogic?
	
	// Original: private let beerUrl: String = "https://api.punkapi.com/v2/beers?page=\(pageNumber)&per_page=80"
	private let worker: BeersStoreProtocol = BeersWorker()
	
	// MARK: - Public Methods
	
	
	// MARK: - Private Methods
}


// MARK: - Extension. BeersCollectionBusinessLogic
extension BeersCollectionInteractor: BeersCollectionBusinessLogic {
	func doLoadStaticData(request: BeersCollection.StaticData.Request) {
		let response = BeersCollection.StaticData.Response()
		presenter?.presentStaticData(response: response)
	}
	
	
	func fetchBeers(request: BeersCollection.FetchBeers.Request) {
		worker.fetchBeers(withPaginationNumber: 1) { beersResult in
			switch beersResult {
			case .success(let beers):
				let response = BeersCollection.FetchBeers.Response(beers: beers)
				self.presenter?.presentBeersCollection(response: response)
				
			case .failure:
				self.presenter?.fetchBeersCollectionDidFail(error: "Error Fetching the beers")
			}
		}
	}
}
