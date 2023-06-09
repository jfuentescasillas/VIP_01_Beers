//
//  BeersCollectionInteractor.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation
import Combine


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
	// MARK: - Public Properties
	var beersCollection: [BeerModel]?
	var presenter: BeersCollectionPresentationLogic?
	
	// MARK: - Private Properties
	private var cancellable 	  		  = Set<AnyCancellable>()
	private var paginationNr: Int 		  = 2
	private var numberOfBeersFetched: Int = 0
	private var viewModel 				  = [BeerModel]()
	private var viewModelAux		 	  = [BeerModel]()
	
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
		// Process using URLSession
		/* worker.fetchBeers(withPaginationNumber: 1) { beersResult in
			switch beersResult {
			case .success(let beers):
				let response = BeersCollection.FetchBeers.Response(beers: beers)
				self.presenter?.presentBeersCollection(response: response)
				
			case .failure:
				self.presenter?.fetchBeersCollectionDidFail(error: "Error Fetching the beers")
			}
		} */
		
		
		// Process using Combine Version 1
		// viewController?.startActivity()  ----> Use: self.presenter?.startActivity()
		
		worker.fetchCharactersFromAPIBusiness(withPagination: paginationNr) { [weak self] resultArray in
			guard let self else { return }
			guard let resultArray else { return }
			
			self.viewModel.removeAll()
			self.viewModel 	  = resultArray
			self.viewModelAux = self.viewModel
			self.numberOfBeersFetched = resultArray.count
			
			let response = BeersCollection.FetchBeers.Response(beers: self.viewModel)
			self.presenter?.presentBeersCollection(response: response)
			
			// self.viewController?.stopAndHideActivity()  ----> Use: self.presenter?.stopAndHideActivity()
		} failure: { [weak self] errorApi in
			guard self != nil else { return }
			guard let errorString = errorApi?.localizedDescription else { return }
			
			let errorInt: Int = Int(errorString) ?? -100
			
			switch errorInt {
			case (400...499):
				print("self.viewController?.showClientRequestErrorMsg()")
				
			case (500...599):
				print("self.viewController?.showServerErrorMsg()")
				
			default:
				print("self.viewController?.showNoInternetMsg()")
			}
			
			print("errorApi?.localizedDescription fetching chars: \(errorApi?.localizedDescription ?? "Error fetching chars")")
		}
	}
}
