//
//  ResturantDao.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/18/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import Alamofire
class ResturantDAO {
    
    
    public static  func login( email : String , pass :String , completionHandler:@escaping(Int)->Void)
        
    {
        let params : String = "?email="+email+"&password="+pass
        
        
        var code: Int = 0
        var restaurant : Resturant?
        let url : String = Et3amRestuarantAPI.restaurantBaseURL + RestaurantURLs.loginURL.rawValue + params
        Alamofire.request(url).responseJSON {
            response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                     code =  (json["code"] as? Int)!
                    if code == 1{
                        let results =  json["restaurantAdmin"] as! NSDictionary
                        //    print(results)
                        let restaurantDetails = results["restaurants"] as!  NSDictionary
                        let restaurantId  = restaurantDetails["restaurantId"] as!  Int
                        let restaurantName = restaurantDetails["restaurantName"] as!  String
                        print(restaurantName)
                        let restaurantImage = restaurantDetails["restaurantImage"] as!  String
                        print(restaurantImage)
                        restaurant = Resturant(restaurantId: restaurantId,name: restaurantName ,pass: pass , image: restaurantImage, email: email)
                        
                        UserStoredData.saveInUserDefaults(restaurant: restaurant!)
                    }
                    completionHandler(code)
                    
                } catch{
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                
            }
            
        }
       
        
        
    }
   
   
}





