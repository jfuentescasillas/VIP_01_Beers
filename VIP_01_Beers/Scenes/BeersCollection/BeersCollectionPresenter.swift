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
	
	
	// MARK: - Private Methods
}
