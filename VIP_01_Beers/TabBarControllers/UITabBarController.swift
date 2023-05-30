//
//  UITabBarController.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 30/05/23.
//


import UIKit


class GFTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initialConfig()
	}
	
	
	// MARK: - Initial Configuration
	private func initialConfig() {
		UITabBar.appearance().tintColor = .systemGreen
		viewControllers 				= [createBeersListNavContr(), createFavoritesNavContr()]
	}
	
	
	// MARK: - Create Navigation Controller Methods
	private func createBeersListNavContr() -> UINavigationController {
		let beersCollectionVC = BeersCollectionViewController()
		beersCollectionVC.tabBarItem = UITabBarItem(title: "Beers",
												  image: UIImage(named: "beerNavBarImage-29x29"),
												  tag: 0)
		beersCollectionVC.title = "Indie Beers"
		
		return UINavigationController(rootViewController: beersCollectionVC)
	}
	
	
	private func createFavoritesNavContr() -> UINavigationController {
		let favoriteBeersVC 		= FavoriteBeersViewController()
		favoriteBeersVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		favoriteBeersVC.title = "Favorite Indie Beers"
		
		return UINavigationController(rootViewController: favoriteBeersVC)
	}
}
