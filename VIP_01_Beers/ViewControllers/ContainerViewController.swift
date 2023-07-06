//
//  ContainerViewController.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 20/06/23.
//
// Source: https://www.youtube.com/watch?v=1hzPFAYcuUI


import UIKit


class ContainerViewController: UIViewController {
	// MARK: - Properties
	private let menuVC = MenuViewController()
	private let mainVC = BeersTabBarController()
	private let beersCollectionVC = BeersCollectionViewController()
	
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addChildVCs()
	}
	
	
	// MARK: - Private Methods
	private func addChildVCs() {
		// MenuVC
		addChild(menuVC)
		view.addSubview(menuVC.view)
		menuVC.didMove(toParent: self)
		
		// Main BeersTabBarController
		addChild(mainVC)
		view.addSubview(mainVC.view)
		mainVC.didMove(toParent: self)
	}
}
