//
//  BeersBodyLabel.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 31/05/23.
//


import UIKit


class BeersBodyLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		
		self.textAlignment = textAlignment
	}
	
	
	private func configure() {
		textColor 						  = .secondaryLabel
		font 							  = UIFont.preferredFont(forTextStyle: .body)
		adjustsFontSizeToFitWidth		  = true
		adjustsFontForContentSizeCategory = true
		minimumScaleFactor 				  = 0.7
		lineBreakMode 					  = .byWordWrapping
		translatesAutoresizingMaskIntoConstraints = false
	}	
}
