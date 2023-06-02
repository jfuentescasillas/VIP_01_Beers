//
//  BeersCollectionViewController.swift
//  VIP_01_Beers
//
//  Created Jorge Fuentes Casillas on 30/05/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit


// MARK: - Protocols
protocol BeersCollectionDisplayLogic: AnyObject {
	func displayStaticData(viewModel: BeersCollection.StaticData.ViewModel)
	func displayBeersList(viewModel: BeersCollection.FetchBeers.ViewModel)
}


// MARK: - Class
class BeersCollectionViewController: UIViewController {
	// MARK: - Properties
	var interactor: BeersCollectionBusinessLogic?
	var router: (BeersCollectionRoutingLogic & BeersCollectionDataPassing)?
	
	private let sceneView = BeersCollectionView()
	
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
		let interactor = BeersCollectionInteractor()
		let presenter = BeersCollectionPresenter()
		let router = BeersCollectionRouter()
		
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
		
		sceneView.delegate = self
		
		setupNavigationBar()
		doLoadStaticData()
		fetchBeersOnLoad()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		
	}
	
	
	// MARK: - Private Methods
	private func fetchBeersOnLoad() {
		let request = BeersCollection.FetchBeers.Request()
		interactor?.fetchBeers(request: request)
	}
	
	
	private func setupNavigationBar() {
	}
}


// MARK: - Extension. Output
extension BeersCollectionViewController {
	private func doLoadStaticData() {
		let request = BeersCollection.StaticData.Request()
		interactor?.doLoadStaticData(request: request)
	}
}

// MARK: - Extension. BeersCollectionDisplayLogic (Input)
extension BeersCollectionViewController: BeersCollectionDisplayLogic {
	func displayStaticData(viewModel: BeersCollection.StaticData.ViewModel) {
		
	}
	
	
	func displayBeersList(viewModel: BeersCollection.FetchBeers.ViewModel) {
		print("In the VIEWCONTROLLER (and the cycle is closed), the viewModel is: \(viewModel)")
		print("-----------------------")
		
	}
}


// MARK: - Extension. BeersCollectionViewDelegate
extension BeersCollectionViewController: BeersCollectionViewDelegate {
	func beersCollectionViewButtonPressed(_ view: BeersCollectionView) {
		
	}
}
