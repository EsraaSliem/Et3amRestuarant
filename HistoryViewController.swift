//
//  HistoryViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let resuableIdentifier : String = "cell"
    var restCouponList : Array<UsedCoupon>=[]
    let parameters : [String:Int] = [
        "restaurantId" :  UserStoredData.returnUserDefaults().restaurantId!
    ]
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
            CouponDAO.getUsedCoupon(parameters: parameters ){
            (couponList) in
            self.restCouponList = couponList
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Handler
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restCouponList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: resuableIdentifier)! as! HistoryTableViewCell
        cell.barCodeLabel?.text = restCouponList[indexPath.row].barCode
        cell.dateLabel?.text = String(describing: restCouponList[indexPath.row].couponDate)
        cell.priceLabel?.text = String(describing: restCouponList[indexPath.row].couponValue ?? 0)
        return cell
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
