//
//  VerificationViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import Alamofire
class VerificationViewController: UIViewController {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var barCodeTextField: UITextField!
    @IBOutlet weak var verifiedButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        verifiedButton.layer.cornerRadius = 15
        verifiedButton.clipsToBounds=true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
