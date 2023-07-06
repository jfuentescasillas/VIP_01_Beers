//
//  MenuViewController.swift
//  VIP_01_Beers
//
//  Created by Jorge Fuentes Casillas on 20/06/23.
//
// Source:


import UIKit


/* // MARK: - Protocols
protocol MenuViewControllerDelegate: AnyObject {
	func didSelect(menuItem: MenuOptions)
} */


// MARK: - Class
class MenuViewController: UIViewController {
	// MARK: - Properties
	private let currentLanguageIdentifier = Locale.current.identifier
	private var selectedMenuOption: MenuOptions!
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray3
        label.text = "  " + "selectLanguageTitle".localized
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
	private let menuTableView: UITableView = {
		let table = UITableView()
		table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		table.backgroundColor = .systemGray3
		
		return table
	}()
	
    /* private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("closeBtnTitle".localized, for: .normal)        
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
       
        return button
    }() */
	
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
		configTableView()
		configLocale()
    }
	
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
        
        let heightPadding: CGFloat = 40
        //let widthPadding: CGFloat = 80
        
        titleLabel.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
                                  width: view.bounds.width,
                                  height: heightPadding)
        /*closeButton.frame = CGRect(x: view.bounds.width - widthPadding,
                                   y: view.safeAreaInsets.top,
                                   width: widthPadding,
                                   height: heightPadding)*/
        menuTableView.frame = CGRect(x: 0,
                                     y: view.safeAreaInsets.top + titleLabel.frame.height,
                                     width: view.bounds.width,
                                     height: view.bounds.height - view.safeAreaInsets.top - titleLabel.frame.height)
        
        /* menuTableView.frame = CGRect(x: 0, y: 0,
                                     width: view.bounds.size.width,
                                     height: view.bounds.size.height)
        
        menuTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
										width: view.bounds.size.width,
										height: view.bounds.size.height - view.safeAreaInsets.top)
		        
		menuTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
									 width: view.bounds.size.width,
									 height: view.bounds.size.height) */
	}
	
	
	// MARK: - Private Methods
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        //view.addSubview(closeButton)
    }
    
    
	private func configTableView() {
		view.addSubview(menuTableView)
		menuTableView.dataSource = self
		menuTableView.delegate   = self
		
		view.backgroundColor = .systemGray6
              
	}
	
	
	private func configLocale() {
		switch currentLanguageIdentifier {
		case "es_ES":
			selectedMenuOption = .spanish
		case let langIdentifier where langIdentifier.hasPrefix("es"):
			selectedMenuOption = .spanish_la
		case let langIdentifier where langIdentifier.hasPrefix("fr"):
			selectedMenuOption = .french
		case let langIdentifier where langIdentifier.hasPrefix("it"):
			selectedMenuOption = .italian
		default:
			selectedMenuOption = .english
		}
		
		print("selectedMenuOption: \(selectedMenuOption.localizedString)")
		print("----------------------\n")
	}
    
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - Extension. UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MenuOptions.allCases.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let menuOption = MenuOptions.allCases[indexPath.row]
		cell.contentView.backgroundColor = .systemGray3
		cell.textLabel?.text = menuOption.localizedString
		cell.backgroundColor = nil
		
		if menuOption.localizedString == LocalizedKeys.Languages.localizedString(forIdentifier: currentLanguageIdentifier) {
			cell.imageView?.image	  = UIImage(systemName: "checkmark.circle")
			cell.imageView?.tintColor = .systemGreen
		} else {
			cell.imageView?.image = nil
		}
		
		return cell
	}
}


// MARK: - Extension. UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = MenuOptions.allCases[indexPath.row]
		print("item: \(item)")
		print("----------------------\n")
        dismiss(animated: true)
	}
	
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		menuTableView.cellForRow(at: indexPath)
	}
}
