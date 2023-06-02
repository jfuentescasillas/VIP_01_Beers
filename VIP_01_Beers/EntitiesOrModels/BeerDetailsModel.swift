//
//  BeerDetailsModel.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 02/06/23.
//


import Foundation


// Model to fetch the information of 1 beer (its details)
// from the API by using the codes implemented there
struct BeerDetailsModel: Codable {
	let id: Int
	let name, tagline, firstBrewed, beerDescription: String
	let imageURL: String?
	let abv: Double?
	let ibu: Double?
	let targetFg: Int?
	let targetOg: Double?
	let ebc, srm, ph: Double?
	let attenuationLevel: Double?
	let foodPairing: [String]?
	let brewersTips: String?
	let contributedBy: String
	
	
	enum CodingKeys: String, CodingKey {
		case id, name, tagline
		case firstBrewed 	  = "first_brewed"
		case beerDescription  = "description"
		case imageURL 		  = "image_url"
		case abv, ibu
		case targetFg 		  = "target_fg"
		case targetOg 		  = "target_og"
		case ebc, srm, ph
		case attenuationLevel = "attenuation_level"
		case foodPairing   	  = "food_pairing"
		case brewersTips   	  = "brewers_tips"
		case contributedBy 	  = "contributed_by"
	}
}
