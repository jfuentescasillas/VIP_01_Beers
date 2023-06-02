//
//  BeersCollectionModels.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation


// MARK: - Use cases
enum BeersCollection {
	enum StaticData {
		struct Request {
		}
		
		struct Response {
		}
		
		struct ViewModel {
		}
	}
	
	
	enum FetchBeers {
		struct Request {
			// Request
		}
		
		struct Response {
			// Response
			var beers: [BeerModel]
		}
	
		struct ViewModel {
			// ViewModel
			struct DisplayedBeer {
				var beerID: Int
				var beerName: String
				var beerDescription: String
				var beerImgURL: String
			}
			
			var displayedBeers: [DisplayedBeer]
		}
	}
}


// MARK: - Business models


// MARK: - View models
struct BeersCollectionViewData {
}
