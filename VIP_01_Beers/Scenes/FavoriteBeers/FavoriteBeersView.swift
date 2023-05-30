//
//  FavoriteBeersView.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit


class FavoriteBeersView: UIView {
	// MARK: - Constants
	private struct ViewTraits {
	}
	
	
	// MARK: - Properties
	
	
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
	func setupUI(data: FavoriteBeersViewData) {
	}
	
	
	// MARK: - Private Methods
	private func setupComponents() {
		backgroundColor = .systemGray6
	}
	
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
		])
	}
}
