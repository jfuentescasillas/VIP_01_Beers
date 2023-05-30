//
//  FavoriteBeersInteractor.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation


// MARK: - Protocols
protocol FavoriteBeersBusinessLogic {
	func doLoadStaticData(request: FavoriteBeers.StaticData.Request)
}


protocol FavoriteBeersDataStore {
}


// MARK: - Class
class FavoriteBeersInteractor: FavoriteBeersDataStore {
	// MARK: - Properties
	var presenter: FavoriteBeersPresentationLogic?
	
	
	// MARK: - Public Methods
	
	
	// MARK: - Private Methods
}


// MARK: - Extension. FavoriteBeersBusinessLogic
extension FavoriteBeersInteractor: FavoriteBeersBusinessLogic {
	func doLoadStaticData(request: FavoriteBeers.StaticData.Request) {
		let response = FavoriteBeers.StaticData.Response()
		presenter?.presentStaticData(response: response)
	}
}
