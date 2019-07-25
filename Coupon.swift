//
//  Coupon.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
struct UsedCoupon {
    
    var barCode : String?
    var couponValue : Double?
    var couponDate : Double?
    var couponStatus: Int?
    
    
    
    func getCreationDate(milisecond: Double) -> String {
        let dateVar = Date(timeIntervalSince1970: (milisecond / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a dd/MM/yyyy"
        let date = dateFormatter.string(from: dateVar)
        print(date)
        return date
    }
    
}
