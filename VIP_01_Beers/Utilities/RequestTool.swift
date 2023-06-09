//
//  RequestTool.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 03/06/23.
//


import Foundation


// MARK: - HTTPMethods
enum HTTPMethods: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
	case patch = "PATCH"
}


// MARK: - Request
protocol Request {
	associatedtype Model
	typealias httpHeaders = [String: String]
	
	var baseURL: String { get }
	var endpoint: String { get }
	var httpHeaders: httpHeaders { get }
	var params: [String: Any] { get }
	var httpMethod: HTTPMethods { get }
	
	init(model: Model)
}


extension Request {
	var httpHeaders: httpHeaders {
		return ["Content_Type": "application/json",
				"Accept": "application/json"]
	}
}


// MARK: - Request Model
struct BeerRequestModel: Request {
	var baseURL: String
	var endpoint: String
	
	var params: [String: Any]
	var httpMethod: HTTPMethods { HTTPMethods.get }
	
	init(model: BeerFetchModel) {
		baseURL = "https://api.punkapi.com/v2/beers"
		params = [:]
		endpoint = baseURL + model.paramStrings
	}
	
	typealias Model = BeerFetchModel
}
