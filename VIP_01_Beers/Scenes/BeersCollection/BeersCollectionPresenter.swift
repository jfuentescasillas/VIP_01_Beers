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
		print("In the PRESENTER, the response is: \(response)")
		print("-----------------------")
		
		var displayedBeerViewModel = [BeersCollection.FetchBeers.ViewModel.DisplayedBeer]()
		
		for beer in response.beers {
			let displayedBeer = BeersCollection.FetchBeers.ViewModel.DisplayedBeer(
				beerID: beer.id,
				beerName: beer.name,
				beerDescription: beer.beerDescription,
				beerImgURL: beer.imageURL ?? "https://images.punkapi.com/v2/keg.png")
			
			displayedBeerViewModel.append(displayedBeer)
		}
		
		let viewModel = BeersCollection.FetchBeers.ViewModel(displayedBeers: displayedBeerViewModel)
		viewController?.displayBeersList(viewModel: viewModel)
	}
	
	
	func fetchBeersCollectionDidFail(error: String) {
		print("In the PRESENTER, the error was: \(error)")
	}
	
		
	// MARK: - Private Methods
}
