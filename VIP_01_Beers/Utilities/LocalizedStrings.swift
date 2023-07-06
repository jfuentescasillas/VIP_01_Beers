//
//  LocalizedStrings.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 19/06/23.
//


import Foundation


struct LocalizedKeys {
	struct Languages {
		static let englishLang   = "englishLanguage".localized
		static let frenchLang    = "frenchLanguage".localized
		static let spanishLALang = "spanishLALanguage".localized
		static let spanishLang 	 = "spanishLanguage".localized
		static let italianLang	 = "italianLanguage".localized
		
		
		static func localizedString(forIdentifier identifier: String) -> String {
			switch identifier {
			case let langIdentifier where langIdentifier.hasPrefix("fr"):
				return frenchLang
			case "es_ES":
				return spanishLang
			case let langIdentifier where langIdentifier.hasPrefix("es"):
				return spanishLALang
			case let langIdentifier where langIdentifier.hasPrefix("it"):
				return italianLang
			default:
				return englishLang
			}
		}
	}
	
	
	// MARK: - Alert Controller
	struct AlertControllerErrorTitle {
		static let noInternetTitle  = "alertControllerNoInternetTitle".localized
		static let clientErrorTitle = "clientErrorTitle".localized
		static let serverErrorTitle = "serverErrorTitle".localized
		/* static let unableToRequestDefault 	 	= "unableToRequestDefault".localized
		static let badStuffHappenedTitle 	 	= "badStuffHappenedTitle".localized
		static let successTitle 		 	 	= "successTitle".localized
		static let emptyUsernameTitle 		 	= "emptyUsernameTitle".localized
		static let unableToRemoveTitle			= "unableToRemoveTitle".localized
		static let invalidURLTitle			= "invalidURLTitle".localized
		static let noFollowersTitle			= "noFollowersTitle".localized */
	}
	
	
	struct AlertControllerOKMsgs {
		/* static let emptyUsernameMsg				= "emptyUsernameMsg".localized
		static let invalidURLMsg				= "invalidURLMsg".localized
		static let noFollowersMsg				= "noFollowersMsg".localized */
	}
	
	
	struct AlertControllerErrorMsg {
		static let noInternetMsg  = "alertControllerNoInternetMsg".localized
		static let clientErrorMsg = "clientErrorMsg".localized
		static let serverErrorMsg = "serverErrorMsg".localized
		/* static let invalidUsername 				= "invalidUsername".localized
		static let unableToCompleteRequest 		= "unableToCompleteRequest".localized
		static let unableToCompleteTask			= "unableToCompleteTask".localized
		static let invalidData 					= "invalidData".localized
		static let unableToFavorite 			= "unableToFavorite".localized
		static let alreadyInFavorites 			= "alreadyInFavorites".localized */
	}
	
	
	struct AlertControllerBtnTitle {
		static let okButtonTitle = "okBtn".localized
		/* static let successButtonTitle 			= "successBtn".localized
		static let sadButtonTitle 				= "sadBtn".localized */
	}
	
	
	// MARK: - Search ViewController UI
	struct SearchBeerBarPlaceholder {
		/* static let searchVCTextFieldPlaceholder	= "searchVCTextFieldPlaceholder".localized
		static let resultsTextFieldPlaceholder  = "resultsTextFieldPlaceholder".localized */
	}
	
	
	struct SearchFavoriteBeerBarPlaceholder {
		/* static let searchVCTextFieldPlaceholder	= "searchVCTextFieldPlaceholder".localized
		static let resultsTextFieldPlaceholder  = "resultsTextFieldPlaceholder".localized */
	}
	
	// ViewControllers Titles
	struct VCAndTabBarTitles {
		static let beersVCtitle 	 		= "beersNavItemTitle".localized
		static let beersTabBarTitle			= "beersTabBarItem".localized
		
		static let favoriteBeersVCtitle		= "favBeersNavItemTitle".localized
		static let favoriteBeersTabBarTitle	= "favBeersTabBarItem".localized
	}
	
	
	// VC buttons
	struct ButtonsTitles {
		/* static let githubProfile 				= "gitHubProfile".localized
		static let getFollowers  				= "getFollowers".localized */
	}
	
	
	// VC Labels
	struct LabelsContent {
		/* static let noFollowers 	 	 			= "noFollowers".localized
		static let emptyState 	 	 			= "emptyState".localized
		static let publicRepos					= "publicRepos".localized
		static let publicGists					= "publicGists".localized
		static let followersLbl	 	 			= "followersLbl".localized
		static let followingLbl	 	 			= "followingLbl".localized
		static let inGithubSinceLbl				= "inGithubSinceLbl".localized */
	}
}
