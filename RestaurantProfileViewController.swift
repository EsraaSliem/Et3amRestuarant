//
//  RestaurantProfileViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 7/2/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SDWebImage

class RestaurantProfileViewController: UIViewController {
    
    @IBOutlet weak var restImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let rest = UserStoredData.returnUserDefaults()
        titleLabel.title = rest.name
        restImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .original, publicId:rest.image! )), completed: nil)
        emailLabel.text = rest.email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
