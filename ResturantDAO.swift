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
    
    
    public static  func login( email : String , pass :String ) -> Int
        
    {
        let params : String = "?email="+email+"&password="+pass
        
        
        var code: Int = 0
        var restaurant : Resturant = Resturant()
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
                        let id  = results["id"] as!  NSDictionary
                        let restaurantId  = id["restaurantsRestaurantId"] as!  Int
                        print(restaurantId)
                        let restaurantDetails = results["restaurants"] as!  NSDictionary
                        let restaurantName = restaurantDetails["restaurantName"] as!  String
                        print(restaurantName)
                        let restaurantImage = restaurantDetails["restaurantImage"] as!  String
                        print(restaurantImage)
                        restaurant.email = email
                        restaurant.pass = pass
                        restaurant.name = restaurantName
                        restaurant.restaurantId = restaurantId
                        restaurant.image = restaurantImage
                        saveInUserDefaults(restaurant: restaurant)
                    }
                    
                    
                } catch{
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                
            }
            
        }
        return code
        
        
    }
    static func  saveInUserDefaults(restaurant :Resturant){
        
        UserDefaults.standard.set(restaurant.email, forKey: "restaurantAdminEmail")
        UserDefaults.standard.set(restaurant.pass, forKey: "restaurantAdminPass")
        UserDefaults.standard.set(restaurant.restaurantId, forKey: "restaurantAdminId")
        UserDefaults.standard.set( restaurant.image,  forKey: "image")
    }
   
}





