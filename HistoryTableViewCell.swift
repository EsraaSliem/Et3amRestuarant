//
//  HistoryTableViewCell.swift
//  Et3amRestaurant
//  Created by Esraa Sliem on 5/16/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var barCodeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
