//
//  MenuOption.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/14/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import Foundation
import UIKit
enum MenuOption: Int, CustomStringConvertible {
    
    case Profile
    case Inbox
    case Notifications
    case Settings
    
    
    var description: String {
        switch self {
        case .Profile: return "Profile"
        case .Inbox: return "Inbox"
        case .Notifications: return "Notifications"
        case .Settings: return "Settings"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .Inbox: return UIImage(named: "ic_mail_outline_white_2x") ?? UIImage()
        case .Notifications: return UIImage(named: "ic_menu_white_3x") ?? UIImage()
        case .Settings: return UIImage(named: "baseline_settings_white_24dp") ?? UIImage()
        }
    }
}
