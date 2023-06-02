//
//  BeersAlertVC.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 31/05/23.
//

import UIKit

class BeersAlertVC: UIViewController {
	private let containerView = BeersAlertContainerView()
	private let titleLabel = BeersTitleLabel(textAlignment: .center, fontSize: 20)
	private let msgLabel = BeersBodyLabel(textAlignment: .center)
	private let actionBtn = BeerButton(color: .systemPink, title: "Ok", systemImageName: "checkmark.circle")
	private let padding: CGFloat = 20
	
	var alertTitle: String?
	var msg: String?
	var buttonTitle: String?
	
	
	init(alertTitle: String? = nil, msg: String? = nil, buttonTitle: String? = nil) {
		super.init(nibName: nil, bundle: nil)
		
		self.alertTitle = alertTitle
		self.msg = msg
		self.buttonTitle = buttonTitle
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
		
		configContainerView()
		configTitleLabel()
		configureActionButton()
		configureMessageLabel()
	}
	
	
	private func configContainerView() {
		view.addSubview(containerView)
		containerView.backgroundColor	 = .systemBackground
		containerView.layer.cornerRadius = 16
		containerView.layer.borderWidth  = 2
		containerView.layer.borderColor  = UIColor.white.cgColor
		containerView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			containerView.widthAnchor.constraint(equalToConstant: 280),
			containerView.heightAnchor.constraint(equalToConstant: 220)
		])
	}
	
	
	private func configTitleLabel() {
		containerView.addSubview(titleLabel)
		titleLabel.text = alertTitle ?? "Something went wrong"
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			titleLabel.heightAnchor.constraint(equalToConstant: 28)
		])
	}
	
	
	private func configureActionButton() {
		containerView.addSubview(actionBtn)
		actionBtn.setTitle(buttonTitle ?? "LocalizedKeys.alertControllerButtonTitle.okButtonTitle", for: .normal)
		actionBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			actionBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
			actionBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			actionBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			actionBtn.heightAnchor.constraint(equalToConstant: 44)
		])
	}
	
	
	@objc private func dismissVC() {
		dismiss(animated: true)
	}
	
	
	private func configureMessageLabel() {
		containerView.addSubview(msgLabel)
		msgLabel.text = msg ?? "LocalizedKeys.alertControllerErrorMessages.unableToCompleteRequest"
		msgLabel.numberOfLines = 4
		
		NSLayoutConstraint.activate([
			msgLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			msgLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			msgLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			msgLabel.bottomAnchor.constraint(equalTo: actionBtn.topAnchor, constant: -12)
		])
	}
}
