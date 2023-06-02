//
//  UIViewControllerExt.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 31/05/23.
//


import UIKit


extension UIViewController {
	func presentBeersAlert(title: String, message: String, buttonTitle: String) {
		let alertVC = BeersAlertVC(alertTitle: title, msg: message, buttonTitle: buttonTitle)
		alertVC.modalPresentationStyle = .overFullScreen
		alertVC.modalTransitionStyle   = .crossDissolve
		
		present(alertVC, animated: true)
	}
	
	
	func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
