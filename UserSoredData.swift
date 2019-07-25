//
//  UserSoredData.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/30/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
class UserStoredData {
    static var userDefaults = UserDefaults.standard
    static let objectName = "restaurant"
    static var  flag =  false
    static func  saveInUserDefaults(restaurant :Resturant){
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: restaurant)
        userDefaults.set(encodedData, forKey: objectName )
        userDefaults.synchronize()
        flag = true
    }
    
    
    static func returnUserDefaults() -> Resturant?
    {
        
        if let decoded  = userDefaults.data(forKey: objectName){
        let decodedRestaurant = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Resturant
        return decodedRestaurant
        }else{
            return nil
        }
    }
    static func removeUserDefaults()
    {
       userDefaults.removeObject(forKey: objectName)
      
    }
    
}
