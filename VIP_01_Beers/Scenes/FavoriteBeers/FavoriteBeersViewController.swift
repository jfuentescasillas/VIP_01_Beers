//
//  FavoriteBeersViewController.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit


// MARK: - Protocols
protocol FavoriteBeersDisplayLogic: AnyObject {
	func displayStaticData(viewModel: FavoriteBeers.StaticData.ViewModel)
}


// MARK: - Class
class FavoriteBeersViewController: UIViewController {
	// MARK: - Properties
	var interactor: FavoriteBeersBusinessLogic?
	var router: (FavoriteBeersRoutingLogic & FavoriteBeersDataPassing)?
	
	private let sceneView = FavoriteBeersView()
	
	// MARK: - Object's lifecycle
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	
	// MARK: - Setup
	private func setup() {
		let viewController = self
		let interactor = FavoriteBeersInteractor()
		let presenter = FavoriteBeersPresenter()
		let router = FavoriteBeersRouter()
		
		viewController.interactor = interactor
		viewController.router = router
		
		interactor.presenter = presenter
		
		presenter.viewController = viewController
		
		router.viewController = viewController
		router.dataStore = interactor
	}
	
	
	// MARK: - View's lifecycle
	override func loadView() {
		view = sceneView
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupNavigationBar()
		doLoadStaticData()
		hideKeyboardWhenTappedAround()
	}
	
	
	// MARK: - Private Methods
	private func setupNavigationBar() {
	}
}


// MARK: - Extension. Output
extension FavoriteBeersViewController {
	private func doLoadStaticData() {
		let request = FavoriteBeers.StaticData.Request()
		interactor?.doLoadStaticData(request: request)
	}
}

// MARK: - Extension. FavoriteBeersDisplayLogic (Input)
extension FavoriteBeersViewController: FavoriteBeersDisplayLogic {
	func displayStaticData(viewModel: FavoriteBeers.StaticData.ViewModel) {
	}
}
