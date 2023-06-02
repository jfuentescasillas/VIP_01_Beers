//
//  BeersAlertContainerView.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 31/05/23.
//

import UIKit

class BeersAlertContainerView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func configure() {
		backgroundColor = .systemBackground
		layer.cornerRadius = 16
		layer.borderWidth = 2	 // This is to make it noticeable on dark mode
		layer.borderColor = UIColor.white.cgColor
		translatesAutoresizingMaskIntoConstraints = false
	}
}
