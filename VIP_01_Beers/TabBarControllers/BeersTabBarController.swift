//
//  BeersTabBarController.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 20/06/23.
//


import UIKit


class BeersTabBarController: UITabBarController {
	// MARK: - Enums
	enum MenuState {
		case opened
		case closed
	}
	
	
	// MARK: - Properties
	private let menuViewController   = MenuViewController()
	private let beersCollectionVC 	 = BeersCollectionViewController()
	private let favoriteBeersVC 	 = FavoriteBeersViewController()
	private let vcAndTabBarTitles	 = LocalizedKeys.VCAndTabBarTitles.self
	private var menuState: MenuState = .closed
	private var navVC: UINavigationController?
	
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initialConfig()
	}
	
	
	// MARK: - Initial Configuration
	private func initialConfig() {
		UITabBar.appearance().tintColor = .systemGreen
		viewControllers 				= [createBeersListNavContr(), createFavoritesNavContr()]
	}
	
	
	// MARK: - Private Methods
	// Create Navigation Controller Methods
	private func createBeersListNavContr() -> UINavigationController {
		beersCollectionVC.delegate = self
		beersCollectionVC.title = vcAndTabBarTitles.beersVCtitle
		beersCollectionVC.tabBarItem = UITabBarItem(title: vcAndTabBarTitles.beersTabBarTitle,
													image: UIImage(named: "beerNavBarImage-29x29"),
													tag: 0)
		navVC = UINavigationController(rootViewController: beersCollectionVC)
		
		return navVC ?? UINavigationController()
	}
	
	
	private func createFavoritesNavContr() -> UINavigationController {
		favoriteBeersVC.title = vcAndTabBarTitles.favoriteBeersVCtitle
		favoriteBeersVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
				
		return UINavigationController(rootViewController: favoriteBeersVC)
	}
}


// MARK: - Extension. BeersCollectionDelegate
extension BeersTabBarController: BeersCollectionDelegate {
	func didTapMenuBtn() {
        switch menuState {
		case .closed:
			// Open Menu
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8,
						   initialSpringVelocity: 0, options: .curveEaseInOut) { [weak self] in
				guard let self else { return }
                
                let lateralPadding: CGFloat = 1.75 / 7
				
                self.navVC?.view.frame.origin.x = (self.navVC?.view.frame.size.width)! * lateralPadding
                self.view.frame.origin.x = self.view.frame.size.width * lateralPadding
                self.beersCollectionVC.tabBarController?.tabBar.isHidden = true
			} completion: { [weak self] done in
				guard let self else { return }
				
				if done {
					self.menuState = .opened
				}
			}
			
		case .opened:
			// Close Menu
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8,
						   initialSpringVelocity: 0, options: .curveEaseInOut) { [weak self] in
				guard let self else { return }
				
				self.navVC?.view.frame.origin.x = 0
                self.view.frame.origin.x = 0
			} completion: { [weak self] done in
				guard let self else { return }
				
				if done {
					self.menuState = .closed
					self.beersCollectionVC.tabBarController?.tabBar.isHidden = false
				}
			}
		}
	}
}
