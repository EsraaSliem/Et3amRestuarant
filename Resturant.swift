//
//  Resturant.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/18/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
class Resturant :NSObject, NSCoding{
    
    var restaurantId : Int?
    var email : String?
    var pass : String?
    var name : String?
    var image : String?
    
    func encode(with aCoder: NSCoder)  {

        aCoder.encode(restaurantId, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(name, forKey: "email")
        aCoder.encode(pass, forKey: "pass")
        aCoder.encode(image, forKey: "image")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        restaurantId = aDecoder.decodeObject(forKey: "id") as! Int
        name = aDecoder.decodeObject(forKey: "name") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        pass = aDecoder.decodeObject(forKey: "pass") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
        
    }
    
    init(restaurantId :Int ,name: String,pass:String, image: String , email:String) {
        
        self.name = name
        self.restaurantId = restaurantId
        self.pass = pass
        self.email = email
        self.image = image
        
    }
    
}
