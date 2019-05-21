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
    
    
    public static  func login( email : String , pass :String ) -> Resturant
        
    {
        let params : String = "?email="+email+"&password="+pass
        var restaurant : Resturant = Resturant()
        let url : String = Et3amRestuarantAPI.baseURL + RestaurantURLs.loginURL.rawValue + params
        Alamofire.request(url).responseJSON {
            response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    let results =  json["restaurant"] as! Array< NSDictionary >
                    
                    for i in results
                    {
                       
                        restaurant.pass = i["restaurantAdminPassword"] as?  String
                        restaurant.email = i["restaurantAdminEmail"] as?  String
                        restaurant.restaurantId = i["restaurantId"] as?  Int
                        
                    }
                    
                } catch{
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                
            }
            
        }
        return restaurant
        
        
    }
}
