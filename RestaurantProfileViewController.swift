//
//  RestaurantProfileViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 7/2/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class RestaurantProfileViewController: UIViewController {
    // MARK :- outlets
    @IBOutlet weak var restImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    @IBOutlet weak var totalDealsLabel: UILabel!
    @IBOutlet weak var couponNumUnpaidLabel: UILabel!
    @IBOutlet weak var couponNumpaidLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var topMealLabel: UILabel!
    
    //MARK :- property
    var usedCouponList: [UsedCoupon] = []
    let rest = UserStoredData.returnUserDefaults()
    var pageNum = 1
    
    //MARK :- init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        loadCoupons()
        
    }
    
    //MARK :- loadData
    func loadData() {
        titleLabel.title = rest?.name
        restImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .original, publicId:(rest?.image!)! )),
                                  completed: nil)
        emailLabel.text = rest?.email
    }
    
    
    func loadCoupons(){
        print("enter funccccccc")
        SVProgressHUD.show()
        CouponDAO.getUsedCoupon(restId: (rest?.restaurantId!)!,pageNum: pageNum)
        {
            (couponList)
            in
            if !couponList.isEmpty
            {
                self.usedCouponList.append(contentsOf: couponList)
                print("iffffff")
                self.pageNum = self.pageNum + 1
                self.loadCoupons()
            }
           
            else
            {
                 print("elseeeee")
                self.calculateDealsOperation()
                
                
            }
            
        }
    }
    
    func calculateDealsOperation()
    {
        totalDealsLabel.text = String(usedCouponList.count)+"D"
        let paidList = usedCouponList.filter(
            {
                $0.couponStatus == 1
            }
        )
        
        let totalAmountDeals = usedCouponList.reduce(0, { $0 + $1.couponValue!})
        let paidMealsAmount = paidList.reduce(0, { $0 + $1.couponValue!})
        let unpaidAmount = totalAmountDeals - paidMealsAmount
        totalAmountLabel.text = String(totalAmountDeals)+"E"
        couponNumpaidLabel.text = String(paidList.count)+"D / "+String(paidMealsAmount)+"E"
        couponNumUnpaidLabel.text = String (usedCouponList.count - paidList.count)+"D / "+String(unpaidAmount)+"E"
        self.getTopMeal()
        
    }
    
    func getTopMeal()
    {
        MealDAO.getTopMeal(resturantId: (rest?.restaurantId!)!){
            self.topMealLabel.text = $0
            SVProgressHUD.dismiss()
            
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        UserStoredData.removeUserDefaults()
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
}
