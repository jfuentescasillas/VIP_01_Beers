//
//  FavoriteBeersPresenter.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation


// MARK: - Protocols
protocol FavoriteBeersPresentationLogic {
	func presentStaticData(response: FavoriteBeers.StaticData.Response)
}


// MARK: - Class
class FavoriteBeersPresenter: FavoriteBeersPresentationLogic {
	// MARK: - Properties
	weak var viewController: FavoriteBeersDisplayLogic?
	
	
	// MARK: - Public Methods
	func presentStaticData(response: FavoriteBeers.StaticData.Response) {
		let viewModel = FavoriteBeers.StaticData.ViewModel()
		viewController?.displayStaticData(viewModel: viewModel)
	}
	
	
	// MARK: - Private Methods
}
