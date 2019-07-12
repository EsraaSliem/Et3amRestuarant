//
//  VerificationViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import Alamofire
import CoreGraphics
import SVProgressHUD
import SystemConfiguration
class VerificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties
    
    @IBOutlet weak var popupTitleLabel: UILabel!
    @IBOutlet weak var barCodeTextField: UITextField!
    @IBOutlet weak var verifiedButton: UIButton!
    @IBOutlet weak var titleNavBar: UINavigationItem!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectButton: UIButton!
    var mealList : [Meal] = []
    var selectedMeal: Meal?
    var couponPrice: Double = 0.0
    var page = 1
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNavBar.title = UserStoredData.returnUserDefaults().name
        self.tableView.delegate = self
        self.tableView.dataSource = self
        popUpView.layer.cornerRadius = 10
        //        verifiedButton.clipsToBounds=true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func verify(_ sender: Any) {
        let code = barCodeTextField.text!
        CouponDAO.checkCouponReservation(code: code){
            (couponValue)
            in
            print(couponValue)
            if couponValue != nil {
                self.popupTitleLabel.text = "Coupon "+String(describing: couponValue!)+"LE"
                self.couponPrice = couponValue!
                self.loadMeals(pageNum: self.page)
                self.tableView.isHidden = true
                self.popUpView.center = self.view.center
                self.view.addSubview(self.popUpView)
            }
            else
            {
                SVProgressHUD.showError(withStatus: "invalid barcode")
            }
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        UserStoredData.removeUserDefaults()
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.present(loginVC, animated: true, completion: nil)
        
    }
}
extension VerificationViewController {
    
    func loadMeals(pageNum : Int){
        
        MealDAO.getMeals(resturantId: UserStoredData.returnUserDefaults().restaurantId!, pageNum: page)
        {
            (meals)
            in
            if  !meals.isEmpty
            {
                self.mealList.append(contentsOf: meals)
                self.page = self.page + 1
                self.loadMeals(pageNum: self.page)
                print("enter")
                print(self.mealList)
            }
            else
            {
                let tempList = self.mealList.filter({$0.price! <= self.couponPrice})
                self.mealList = tempList
                self.tableView.reloadData()
                
            }
            
        }
    }
    
    @IBAction func selectMeal(_ sender: Any) {
        self.tableView.isHidden = false
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        if let selectedMeal2 = selectedMeal
        {
            CouponDAO.useCoupon(restId: UserStoredData.returnUserDefaults().restaurantId!, code: barCodeTextField.text! ,price: selectedMeal2.price!,mealId: selectedMeal2.mealId!)
            {
                (id)
                in
                if let id = id{
                    self.popUpView.removeFromSuperview()
                    SVProgressHUD.showSuccess(withStatus: "usedSucessfully")
                    
                }
                else
                {
                    SVProgressHUD.showError(withStatus: "something Error")
                }
            }
            
        }
        else{
            popUpView.removeFromSuperview()
            SVProgressHUD.showError(withStatus: "nothing selected")
        }
        
        
        
        
    }
    @IBAction func close(_ sender: Any) {
        popUpView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(mealList.count) )
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPopUp", for: indexPath)
        
        cell.textLabel?.text = mealList[indexPath.row].name!
        cell.detailTextLabel?.text = String(mealList[indexPath.row].price!)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeal = mealList[indexPath.row]
        selectButton.setTitle(mealList[indexPath.row].name, for: .normal)
        self.tableView.isHidden = true
        
        
    }
    
}
