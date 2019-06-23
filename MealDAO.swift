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
    
    static func addMeal( parameters : [String:Any] ,restaurantId :Int, completionHandler:@escaping(Int?)->Void)
        
    {
        var code = 0
        var id: Int?
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
                                if(code == 1)
                                {
                                   id = (returnedData["id"] as? Int)!
                                }
                                 completionHandler(id)
                                break
                            case .failure(let error):
                                print(error)
                                
                            }
                            
        }
       
        
    }
    
    static  func getMeals( resturantId : Int ,completionHandler:@escaping(Array<Meal>)->Void )
        
    {
        var meals : Array<Meal> = []
        let url : String = Et3amRestuarantAPI.restaurantBaseURL+String(resturantId)+MealURLs.allMeals.rawValue
        Alamofire.request(url).responseJSON {
            response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<NSDictionary>
                    print(json)
                    //  let results =  json["restaurant"] as! Array< NSDictionary >
                    
                    for i in json
                    {
                        var meal : Meal = Meal()
                        meal.mealId = i["mealId"] as?  Int
                        print(meal.mealId! )
                        meal.name = i["mealName"] as?  String
                        meal.price = i["mealValue"] as?  Double
                        meal.image = i["mealImage"] as?  String
                        
                        print(meal.image)
                        meals.append(meal)
                        
                    }
                    completionHandler(meals)
                } catch
                {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        
    }
    public static  func updateMeal(parameters : [String:Any] ,rest_id :Int , meal_id : Int , completionHandler:@escaping(Meal)->Void)
        
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
                                meal.mealId = meal_id
                                meal.name = returnedData["mealName"] as? String
                                meal.price = returnedData["mealValue"] as? Double
                                meal.image = returnedData["mealImage"] as? String
                                print(returnedData)
                                completionHandler(meal)
                                break
                            case .failure(let error):
                                print(error)
                                
                            }
                            
        }
        
        
        
    }
    
    
    
    public static  func deleteMeal( rest_id : Int , meal_id :Int ) ->Int
        
    {
        
        var code: Int = 0
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




