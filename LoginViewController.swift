//
//  LoginViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/17/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
     // MARK: - Properties
@IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var restaurnatNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
     // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.layer.cornerRadius = 15
        logoImageView.clipsToBounds=true
        loginButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
     // MARK: - Handler

    @IBAction func login(_ sender: Any) {
        let restaurant : Resturant = ResturantDAO.login(email: restaurnatNameTextField.text!, pass:passwordTextField.text!)
        if  restaurant != nil
        {
            
              UserDefaults.standard.set(restaurant.email, forKey: "restaurantAdminEmail")
              UserDefaults.standard.set(restaurant.pass, forKey: "restaurantAdminPass")
              UserDefaults.standard.set(restaurant.restaurantId, forKey: "restaurantAdminId")
              self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        
       
    }
    @IBAction func textFieldEditingChange(_ sender: UITextField) {
        print(sender.text!)
        if !(restaurnatNameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!
        {
         loginButton.isEnabled = true
           
        }
        else
        {
            loginButton.isEnabled = false
        }
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
