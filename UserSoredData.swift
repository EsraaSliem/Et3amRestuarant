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
    static func  saveInUserDefaults(restaurant :Resturant){
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: restaurant)
        userDefaults.set(encodedData, forKey: objectName )
        userDefaults.synchronize()
    }
    
    static func returnUserDefaults() -> Resturant
    {
        let decoded  = userDefaults.data(forKey: objectName)
        let decodedRestaurant = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! Resturant
        return decodedRestaurant
    }
    static func removeUserDefaults()
    {
       userDefaults.removeObject(forKey: objectName)
      
    }
    
}
