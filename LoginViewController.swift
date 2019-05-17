//
//  LoginViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/17/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
@IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var restaurnatNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.layer.cornerRadius = 15
        logoImageView.clipsToBounds=true
        loginButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
         self.performSegue(withIdentifier: "loginSegue", sender: nil)
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
