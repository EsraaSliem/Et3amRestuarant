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
    
    public static  func updateMeal(parameters : [String:Any] ,rest_id :Int , meal_id : Int) -> Meal
        
    {
        
        var meal : Meal = Meal()
        let url : String = Et3amRestuarantAPI.mealBaseURL + String(rest_id) + MealURLs.updateMeal.rawValue + String(meal_id)
        Alamofire.request(url,
                          method: .put,
                          parameters : parameters ,
                          encoding: JSONEncoding.default,
                          
                          headers: nil).responseJSON {
                            response in
                            switch response.result {
                                
                            case .success:
                                print("enter")
                                let sucessDataValue = response.result.value
                                let returnedData = sucessDataValue as! NSDictionary
                                meal.mealId = returnedData["mealId"] as? Int
                                meal.name = returnedData["mealName"] as? String
                                meal.price = returnedData["mealValue"] as? Double
                                meal.image = returnedData["mealImage"] as? String
                                print(returnedData)
                                
                                break
                            case .failure(let error):
                                print(error)
                                
                            }
                            
        }
        
        
        
        return meal
        
        
        
    }
    
    

public static  func deleteMeal( rest_id : Int , meal_id :Int ) -> Int
    
{
 
    var code: Int = 0
    var restaurant : Resturant = Resturant()
    let url : String = Et3amRestuarantAPI.mealBaseURL + String(rest_id) + MealURLs.removeMeal.rawValue + String(meal_id)
    Alamofire.request(url,
                      method: .delete,
                      
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




