//
//  BeersCollectionPresenter.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation


// MARK: - Protocols
protocol BeersCollectionPresentationLogic {
	func presentStaticData(response: BeersCollection.StaticData.Response)
	func presentBeersCollection(response: BeersCollection.FetchBeers.Response)
	func fetchBeersCollectionDidFail(error: String)
}


// MARK: - Class
class BeersCollectionPresenter: BeersCollectionPresentationLogic {
	// MARK: - Properties
	weak var viewController: BeersCollectionDisplayLogic?
	
	
	// MARK: - Public Methods
	func presentStaticData(response: BeersCollection.StaticData.Response) {
		let viewModel = BeersCollection.StaticData.ViewModel()
		viewController?.displayStaticData(viewModel: viewModel)
	}
	
	
	func presentBeersCollection(response: BeersCollection.FetchBeers.Response) {
		print("In the PRESENTER, the response is:")
		print("\(response)")
		print("----------------------------------------------\n")
		
		let displayedBeers: [BeersCollection.FetchBeers.ViewModel.DisplayedBeer] = response.beers.map { beer in
			let displayedBeer =	BeersCollection.FetchBeers.ViewModel.DisplayedBeer(
				beerID: beer.id,
				beerName: beer.name,
				beerDescription: beer.beerDescription,
				beerImgURL: beer.imageURL ?? "https://images.punkapi.com/v2/keg.png")
			
			return displayedBeer
		}
		
		let viewModel = BeersCollection.FetchBeers.ViewModel(displayedBeers: displayedBeers)
		viewController?.displayBeersList(viewModel: viewModel)
	}
	
	
	func fetchBeersCollectionDidFail(error: String) {
		print("In the PRESENTER, the error was: \(error)")
		print("------------------------------------\n")

		let errorInt: Int = Int(error) ?? -1

		switch errorInt {
		case 400...499:
			// Handle client error case
			print("In the PRESENTER, client error case.")
			viewController?.displayErrorFetchingBeers(withError: errorInt)
			print("------------------------------------\n")
			
		case 500...599:
			// Handle server error case
			print("In the PRESENTER, server error case.")
			viewController?.displayErrorFetchingBeers(withError: errorInt)
			print("------------------------------------\n")
		
		default:
			// Handle other errors and no internet connection
			print("In the PRESENTER, default error case.")
			viewController?.displayErrorFetchingBeers(withError: errorInt)
			print("------------------------------------\n")
		}
	}
	
		
	// MARK: - Private Methods
}
