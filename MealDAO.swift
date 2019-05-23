//
//  MealDAO.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/18/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import Alamofire
class MealDAO {
    
    
    
    
    
    //    var meal : Meal
    
    static func addMeal( parameters : [String:Any] ,restaurantId :Int) -> Int
        
    {
        var code = 0
        Alamofire.request(Et3amRestuarantAPI.mealBaseURL + String(restaurantId) + MealURLs.addMeal.rawValue,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON {
                            response in
                            switch response.result {
                           
                            case .success:
                                print("enter")
                                let sucessDataValue = response.result.value
                                let returnedData = sucessDataValue as! NSDictionary
                                print(returnedData)
                                code = (returnedData["code"] as? Int)!
                                break
                            case .failure(let error):
                                print(error)
                                
                            }
                            
        }
        return code
        
        
    }
    
    
}



