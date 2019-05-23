//
//  CouponDAO.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/18/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import Alamofire
class CouponDAO {
    static var coupons : Array<Coupon> = []
    public  static func getMeals( resturantId : Int ) -> Array<Coupon>
        
    {
        let url : String = Et3amRestuarantAPI.restaurantBaseURL+String(resturantId)+MealURLs.allMeals.rawValue
        Alamofire.request(url).responseJSON {
            response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    let results =  json["coupon"] as! Array< NSDictionary >
                    
                    for i in results
                    {
                        var coupon : Coupon = Coupon()
                        coupon.couponId = i["couponId"] as?  Int
                        coupon.barCode = i["mealValue"] as?  Int64
                        coupon.couponValue = i["mealImage"] as? Double
                        self.coupons.append(coupon)
                    }
                    
                } catch{
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                
            }
            
        }
        return coupons
    }
}
