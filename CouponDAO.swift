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
    
    public  static func getUsedCoupon( restId: Int , pageNum:Int, completionHandler:@escaping(Array<UsedCoupon>)->Void )
        
    {
        var coupons : Array<UsedCoupon> = []
        let url : String = Et3amRestuarantAPI.couponBaseURL+CoupponURLs.couponList.rawValue+"?restaurantId="+String( restId)+"&pageNum="+String(pageNum)
        
        print(url)
        //"https://et3am.herokuapp.com/coupon/use_coupon_list?restaurantId=1"
         //  https://et3am.herokuapp.com/coupon/use_coupon_list?restaurantId=2
        Alamofire.request( url,
                          method: .get,
                          // parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil).responseJSON  {
                
                response in
                
                switch response.result {
                case .success:
                    print("sucess")
                    let sucessDataValue = response.result.value
                    let returnedData = sucessDataValue as! NSDictionary
                    
                    print("enter")
                    
                    let code =  returnedData.value(forKey: "code")! as! Int
                    print(code)
                    if(code == 1)
                    {
                        let results =  returnedData.value(forKey: "restaurantCoupons")! as! Array< NSDictionary >
                        for i in results
                        {
                            var coupon : UsedCoupon = UsedCoupon()
                            coupon.barCode = i["barCode"] as?  String
                            coupon.couponDate = i["usedDate"] as? Double
                            coupon.couponValue = i["price"] as? Double
                            coupon.couponStatus = i["status"] as? Int
                             coupons.append(coupon)
                        }
                       
                    }
                     completionHandler(coupons)
                    
                    break
                case .failure(let error):
                    print(error)
                    
                }
                
        }
        
    }
    public  static func checkCouponReservation( code: String , completionHandler:@escaping(Double?)->Void )
        
    {
        var paramCode = "?code="+code
        
        let url : String = Et3amRestuarantAPI.couponBaseURL+CoupponURLs.checkReservation.rawValue+paramCode
        print(url)
        Alamofire.request(url ,
                          method: .get,
                          // parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil).responseJSON  {
                
                response in
                
                switch response.result {
                case .success:
                    print("sucess")
                    let sucessDataValue = response.result.value
                    let returnedData = sucessDataValue as! NSDictionary
                    
                    print("enter")
                    print(returnedData)
                    let code =  returnedData.value(forKey: "code")! as! Int
                    print(code)
                    var x: Double?
                    if(code == 1)
                    {
                        let coupon = returnedData.value(forKey: "coupon")as! Dictionary<String, Any>
                        x = coupon["couponValue"] as?  Double
                    }
                    completionHandler(x)
                    
                    break
                case .failure(let error):
                    print(error)
                    
                }
                
        }
        
    }
    
    public  static func useCoupon(restId: Int ,code: String ,price: Double, mealId: Int, completionHandler:@escaping(Int?)->Void )
        
    {
        
        var params = "?restaurantId="+String(restId)+"&barCode="+code+"&price="+String(price)+"&mealId="+String(mealId)
        let url : String = Et3amRestuarantAPI.couponBaseURL+CoupponURLs.useCoupon.rawValue+params
        print(url)
        Alamofire.request(url ,
                          method: .get,
                          // parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil).responseJSON  {
                
                response in
                
                switch response.result {
                case .success:
                    print("sucess")
                    let sucessDataValue = response.result.value
                    let returnedData = sucessDataValue as! NSDictionary
                    
                    print("enter")
                    print(returnedData)
                    let code =  returnedData.value(forKey: "code")! as! Int
                    print(code)
                    var id: Int?
                    if(code == 1)
                    {
                        id = returnedData["id"] as?  Int
                    }
                    completionHandler(id)
                    
                    break
                case .failure(let error):
                    print(error)
                    
                }
                
        }
        
    }

}
