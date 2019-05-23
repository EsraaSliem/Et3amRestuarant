//
//  Et3amAPI.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/18/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
struct Et3amRestuarantAPI {
    
    static let restaurantBaseURL : String = "https://et3am.herokuapp.com/restaurant/"
    static let mealBaseURL : String = "https://et3am.herokuapp.com/restaurant/rest/"
}


enum MealURLs: String
{
    case  allMeals = "/meals"
    case  addMeal = "/addMeal"
    case removeMeal = "/deleteMeal/"
    case updateMeal = "/updateMeal/"
}



enum RestaurantURLs: String
{
    case loginURL = "validate/login"
    
}


