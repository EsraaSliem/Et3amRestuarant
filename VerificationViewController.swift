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
    // MARK: - Properties
    
    @IBOutlet weak var barCodeTextField: UITextField!
    @IBOutlet weak var verifiedButton: UIButton!
     @IBOutlet weak var titleNavBar: UINavigationItem!
        // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNavBar.title = UserStoredData.returnUserDefaults().name
      
        //        verifiedButton.layer.cornerRadius = 15
        //        verifiedButton.clipsToBounds=true
        // Do any additional setup after loading the view.
    }

    
   
    @IBAction func verify(_ sender: Any) {
        let code = barCodeTextField.text!
        CouponDAO.checkCouponReservation(code: code){
            (id)
            in
            print(id)
            if id != nil {
                let alert = UIAlertController(title: "verified sucessfully!", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "enter meal price plese..."
                })
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    if let price = alert.textFields?.first?.text {
                        
                    CouponDAO.useCoupon(restId: UserStoredData.returnUserDefaults().restaurantId!, code: code, price: Double(price)!)
                        {
                            (id)
                            in
                            if let id = id{
                                self.showToast(message: "sucessful")
                            }
                            else
                            {
                                self.showToast(message: "error")
                            }
                        }
                    }
                }))
                
                self.present(alert, animated: true)
            }
            else
            {
                self.showToast(message: "invalid barcode")
            }
            
        }
        
    }

    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        UserStoredData.removeUserDefaults()
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.present(loginVC, animated: true, completion: nil)
        
    }
}
