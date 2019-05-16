//
//  MealTableViewCell.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var mealPriceLabel: UILabel!
   

    @IBOutlet weak var mealNameLabel: UILabel!
    
    
    @IBOutlet weak var mealImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
