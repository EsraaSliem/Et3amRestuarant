//
//  VerifiedCouponViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/14/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    var delegate: HomeControllerDelegate?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    // MARK: - Handlers
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Side Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "barButtonMenuIcon.png").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
}
