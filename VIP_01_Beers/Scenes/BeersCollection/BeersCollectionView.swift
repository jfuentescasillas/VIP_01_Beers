//
//  BeersCollectionView.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit


// MARK: - Protocols
protocol BeersCollectionViewDelegate: AnyObject {
	func beersCollectionViewButtonPressed(_ view: BeersCollectionView)
}


// MARK: - Class
class BeersCollectionView: UIView {
	// MARK: - Constants
	private struct ViewTraits {
		
	}
	
	
	// MARK: - Properties
	weak var delegate: BeersCollectionViewDelegate?
	
	// MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupComponents()
		setupConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Actions
	
	
	// MARK: - Public Methods
	func setupUI(data: BeersCollectionViewData) {
		
	}
	
	
	// MARK: - Private Methods
	private func setupComponents() {
		backgroundColor = .systemGray3
	}
	
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			
		])
	}
}
