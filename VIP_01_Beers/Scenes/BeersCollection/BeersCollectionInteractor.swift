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
}


protocol BeersCollectionDataStore {
}


// MARK: - Class
class BeersCollectionInteractor: BeersCollectionDataStore {
	// MARK: - Properties
	var presenter: BeersCollectionPresentationLogic?
	
	
	// MARK: - Public Methods
	
	
	// MARK: - Private Methods
}


// MARK: - Extension. BeersCollectionBusinessLogic
extension BeersCollectionInteractor: BeersCollectionBusinessLogic {
	func doLoadStaticData(request: BeersCollection.StaticData.Request) {
		let response = BeersCollection.StaticData.Response()
		presenter?.presentStaticData(response: response)
	}
}
