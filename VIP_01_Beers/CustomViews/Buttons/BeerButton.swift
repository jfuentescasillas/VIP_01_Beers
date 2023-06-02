//
//  BeerButton.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 31/05/23.
//


import UIKit


class BeerButton: UIButton {
	// MARK: - Inits
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	convenience init(color: UIColor, title: String, systemImageName: String) {
		self.init(frame: .zero)
		
		set(color: color, title: title, systemImageName: systemImageName)
	}
	
	
	// MARK: - Private Methods
	private func configure() {
		configuration			   = .filled()
		configuration?.cornerStyle = .medium
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	
	private func set(color: UIColor, title: String, systemImageName: String) {
		configuration?.baseBackgroundColor = color
		configuration?.baseForegroundColor = .white
		configuration?.title 			   = title
		
		configuration?.image = UIImage(systemName: systemImageName)
		configuration?.imagePadding	  = 6
		configuration?.imagePlacement = .leading
	}
}
