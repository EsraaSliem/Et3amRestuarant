//
//  ViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/13/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {

   
         let resuableIdentifier : String = "cell"
        @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.tableView.register(UITableViewCell.self , forCellReuseIdentifier: resuableIdentifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: resuableIdentifier)! as! MealTableViewCell
            
            return cell
            
        }

}

