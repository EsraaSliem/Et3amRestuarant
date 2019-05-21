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
    
    static var meals : Array<Meal> = []
    public  static func getMeals( resturantId : String ) -> Array<Meal>
        
    {
        let url : String = Et3amRestuarantAPI.baseURL+String(resturantId)+MealURLs.allMeals.rawValue
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
                                        var meal : Meal = Meal()
                                        meal.mealId = i["mealId"] as?  Int
                                        meal.price = i["mealValue"] as?  Double
                                        meal.image = i["mealImage"] as?  String
                                        self.meals.append(meal)
         
                                    }
                               
                                } catch{
                                    print(error)
                                }
                                break
                            case .failure(let error):
                                print(error)
                                
                            }
                            
        }
        return meals
  
        
    }
    
    

}


