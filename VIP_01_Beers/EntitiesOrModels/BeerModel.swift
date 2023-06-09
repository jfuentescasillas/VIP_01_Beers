//
//  BeerModel.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 01/06/23.
//


import Foundation


// MARK: - URL
/// Example: https://api.punkapi.com/v2/beers?page=2&per_page=80
/// where base: https://api.punkapi.com/v2/beers
/// key: page, value: 2
/// key: per_page, value: 80
struct BeerFetchModel {
	var page: String
	var perPage: String = "80"
	
	var params: [String: Any] {
		return [
			"page": page,
			"per_page": perPage
		]
	}
	var paramStrings: String {
		return "?page=\(page)&per_page=\(perPage)"
	}
}


// Model to fetch the information of a list of beers
// from the API by using the codes implemented there.
// This BeerModel is used for the CollectionView's cell
struct BeerModel: Codable {
	let id: Int
	let name, beerDescription: String
	let imageURL: String?
	
	
	enum CodingKeys: String, CodingKey {
		case id, name
		case beerDescription  = "description"
		case imageURL 		  = "image_url"
	}
}
