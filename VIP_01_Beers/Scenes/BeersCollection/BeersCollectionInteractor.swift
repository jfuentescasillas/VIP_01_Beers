//
//  BeersCollectionInteractor.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit


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
	private var paginationNr: Int 		  = 1
	private var numberOfBeersFetched: Int = 0
	private var isLoadingMoreBeers: Bool  = false
	private var viewModel 				  = [BeerModel]()
	private var viewModelAux		 	  = [BeerModel]()
	
	private let worker: BeersStoreProtocol = BeersWorker()
	
	
	// MARK: - Private Methods
}


// MARK: - Extension. BeersCollectionBusinessLogic
extension BeersCollectionInteractor: BeersCollectionBusinessLogic {
	// MARK: - Public Methods
	func doLoadStaticData(request: BeersCollection.StaticData.Request) {
		let response = BeersCollection.StaticData.Response()
		presenter?.presentStaticData(response: response)
	}
	
	
	func fetchBeers(request: BeersCollection.FetchBeers.Request) {
		// MARK: Process using URLSession
		/* worker.fetchBeers(withPaginationNumber: paginationNr) { beersResult in
			switch beersResult {
			case .success(let beers):
				let response = BeersCollection.FetchBeers.Response(beers: beers)
				self.presenter?.presentBeersCollection(response: response)
				
			case .failure(let error):
				var errorCode: Int = -100
				
				print("Error code received: \(error.localizedDescription)")
				
				switch error {
				case .clientError(let reason),
						.serverError(let reason):
					guard let reasonInt = Int(reason) else { return }
					
					errorCode = reasonInt
					
				default:
					break
				}
				
				switch errorCode {
				case 400...499:
					print("self.presenter?.showClientRequestErrorMsg()")
				
				case 500...599:
					print("self.presenter?.showServerErrorMsg()")
				
				default:
					print("self.presenter?.showNoInternetMsg()")
				}
				
				// self.presenter?.fetchBeersCollectionDidFail(error: "Error Fetching the beers: \(error)")
			}
		} */
		
		
		// MARK: Process using Combine in the Worker. It Works
		// viewController?.startActivity()  ----> Use: self.presenter?.startActivity()
		
		/* worker.fetchBeersFromAPIBusiness(withPagination: paginationNr) { [weak self] resultArray in
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
				print("self.presenter?.showClientRequestErrorMsg()")
				
			case (500...599):
				print("self.presenter?.showServerErrorMsg()")
				
			default:
				print("self.presenter?.showNoInternetMsg()")
			}
			
			print("errorApi?.localizedDescription fetching chars: \(errorApi?.localizedDescription ?? "Error fetching chars")")
		} */
		
		
		// MARK: Process using async-await. It Works.
		Task {
			do {
				let beers = try await worker.fetchBeers(withPaginationNumber: paginationNr)
				viewModel.removeAll()
				viewModel = beers
				viewModelAux = viewModel
				numberOfBeersFetched = beers.count
				
				let response = BeersCollection.FetchBeers.Response(beers: viewModel)
				presenter?.presentBeersCollection(response: response)
				
				isLoadingMoreBeers = false
			} catch let error as ApiError {
				switch error {
				case .clientError(let reason):
					// Handle client error case
					print("self.presenter?.showClientRequestErrorMsg(): \(reason)")
					print("------------------------------------\n")
					
				case .serverError(let reason):
					// Handle server error case
					print("self.presenter?.showServerErrorMsg(): \(reason)")
					print("------------------------------------\n")
					
				case .noInternetConnection:
					// Handle no internet connection case
					print("self.presenter?.showNoInternetMsg()")
					print("------------------------------------\n")
					
				default:
					// Handle other errors
					print("self.presenter?.showGenericErrorMsg()")
					print("------------------------------------\n")
				}
				
				isLoadingMoreBeers = false
				// dismissLoadingView()
				
			} catch /* let errorCatched */ {
				// Handle unexpected errors. Most probably of type noInternetConnection
				print("------------------------------------\n")
				print("Most probably this is a self.presenter?.showNoInternetMsg() but it should be a self.presenter?.showGenericErrorMsg()")
				// print("Most probably this is a self.presenter?.showNoInternetMsg() but it should be a self.presenter?.showGenericErrorMsg(): \(errorCatched)")
				print("------------------------------------\n")
				
				isLoadingMoreBeers = false
				// dismissLoadingView()
			}
		}
	}
}
