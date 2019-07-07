//
//  Et3amAPI.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/18/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
struct Et3amRestuarantAPI {
    static let baseURL : String = "https://et3am.herokuapp.com/"
    static let restaurantBaseURL : String = "https://et3am.herokuapp.com/restaurant/"
    static let mealBaseURL : String = restaurantBaseURL+"rest/"
    static let couponBaseURL : String = "https://et3am.herokuapp.com/coupon"
}


enum MealURLs: String
{
    case  allMeals = "/meals"
    case  addMeal = "/addMeal"
    case removeMeal = "/deleteMeal/"
    case updateMeal = "/updateMeal/"
    case topMeal = "/top_meal"
    
}



enum RestaurantURLs: String
{
    case loginURL = "validate/login"
    
}

enum CoupponURLs: String
{
    case couponList = "/use_coupon_list"
    case checkReservation = "/check_reservation"
    case useCoupon = "/use_coupon"
    
}


