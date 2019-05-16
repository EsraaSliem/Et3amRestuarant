//
//  MealViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    private let mealResuableIdentifier : String = "cell2"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: mealResuableIdentifier)! as! MealTableViewCell
        cell.mealImageView?.image = #imageLiteral(resourceName: "images.png")
        cell.mealNameLabel?.text = "jhiho"
        cell.mealPriceLabel?.text = "50"
        
        return cell
        
    }

}
