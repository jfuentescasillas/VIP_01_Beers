//
//  BeersCollectionRouter.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit


// MARK: - Protocols
protocol BeersCollectionRoutingLogic {
	func routeBack()
}


protocol BeersCollectionDataPassing {
	var dataStore: BeersCollectionDataStore? { get }
}


// MARK: - Class
class BeersCollectionRouter: BeersCollectionDataPassing {
	// MARK: - Properties
	weak var viewController: BeersCollectionViewController?
	var dataStore: BeersCollectionDataStore?
}


// MARK: - Extension. BeersCollectionRoutingLogic
extension BeersCollectionRouter: BeersCollectionRoutingLogic {
	// MARK: - Routing
	func routeBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}
