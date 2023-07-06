//
//  LocaleLanguages.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 21/06/23.
//


import Foundation


// MARK: - Enums
enum MenuOptions: String, CaseIterable {
	case spanish
	case spanish_la
	case french
	case italian
	case english
	
	var localizedString: String {
		switch self {
		case .spanish:
			return LocalizedKeys.Languages.spanishLang
		case .spanish_la:
			return LocalizedKeys.Languages.spanishLALang
		case .french:
			return LocalizedKeys.Languages.frenchLang
		case .italian:
			return LocalizedKeys.Languages.italianLang
		case .english:
			return LocalizedKeys.Languages.englishLang
		}
	}
}
