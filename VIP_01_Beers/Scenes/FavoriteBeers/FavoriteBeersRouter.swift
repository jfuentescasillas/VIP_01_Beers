//
//  FavoriteBeersRouter.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit


// MARK: - Protocols
protocol FavoriteBeersRoutingLogic {
	func routeBack()
}


protocol FavoriteBeersDataPassing {
	var dataStore: FavoriteBeersDataStore? { get }
}


// MARK: - Class
class FavoriteBeersRouter: FavoriteBeersDataPassing {
	// MARK: - Properties
	weak var viewController: FavoriteBeersViewController?
	var dataStore: FavoriteBeersDataStore?
}


// MARK: - Extension. FavoriteBeersRoutingLogic
extension FavoriteBeersRouter: FavoriteBeersRoutingLogic {
	// MARK: - Routing
	func routeBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}
