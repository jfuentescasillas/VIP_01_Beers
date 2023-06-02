//
//  BeerModel.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 01/06/23.
//


import Foundation


// Model to fetch the information of a list of beers
// from the API by using the codes implemented there
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
