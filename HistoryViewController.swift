//
//  HistoryViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleNavBar: UINavigationItem!
    private let resuableIdentifier : String = "cell"
    var restCouponList : Array<UsedCoupon>=[]
    var filteredRestCouponList : Array<UsedCoupon>=[]
    var viewRestCouponList : Array<UsedCoupon>=[]
    var searchBarIsActive = false
    var pageNum = 1
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        titleNavBar.title = UserStoredData.returnUserDefaults().name
        loadData()
        searchBar.delegate = self
    }
    
    func loadData() {
        SVProgressHUD.show()
        loadCouponsByPageNum(pageNum: pageNum)
        
    }
    func loadCouponsByPageNum(pageNum:Int)
    {
        CouponDAO.getUsedCoupon(restId: UserStoredData.returnUserDefaults().restaurantId!,pageNum: pageNum){
            (couponList)
            in
            print("jjj")
            SVProgressHUD.dismiss()
            if !couponList.isEmpty{
                DispatchQueue.main.async {
                    
                    self.restCouponList.append(contentsOf: couponList)
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    // MARK: - Handler
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsActive  && (filteredRestCouponList.count != 0 ) {
            return filteredRestCouponList.count
        }
        return restCouponList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == restCouponList.count-1)
        {
            pageNum = pageNum + 1
            loadCouponsByPageNum(pageNum: pageNum)
        }
        if searchBarIsActive  && (filteredRestCouponList.count != 0 ) {
            viewRestCouponList = filteredRestCouponList
        }
        else {
            viewRestCouponList = restCouponList
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: resuableIdentifier)! as! HistoryTableViewCell
        cell.barCodeLabel?.text = viewRestCouponList[indexPath.row].barCode
        cell.dateLabel?.text = viewRestCouponList[indexPath.row].getCreationDate(milisecond: restCouponList[indexPath.row].couponDate!)
        cell.priceLabel?.text = String(describing: viewRestCouponList[indexPath.row].couponValue ?? 0)
        switch viewRestCouponList[indexPath.row].couponStatus! {
        case 1:
            cell.statusLabel.text = "paid"
        case 2:
            cell.statusLabel.text = "pending"
        default:
            cell.statusLabel.text = "pending.."
        }
        
        return cell
        
    }
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        UserStoredData.removeUserDefaults()
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        self.present(loginVC, animated: true, completion: nil)
    }
    
}

extension HistoryViewController : UISearchBarDelegate
{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarIsActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredRestCouponList = restCouponList.filter({(coupon) ->Bool in
            let txt: NSString = coupon.barCode! as NSString
            let range = txt.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        self.tableView.reloadData()
        
    }
}
