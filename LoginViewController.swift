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
    @IBOutlet weak var restaurnatEmailTextFie: UITextField!
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
        
        let code :Int  = ResturantDAO.login(email: restaurnatEmailTextFie.text!, pass:passwordTextField.text!)
        
       
        if  (code == 1)
        {

         print("enter")
            //self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        else
        {
            showToast(message: "invalid email or password")
        }
        
        
        
    }
    @IBAction func textFieldEditingChange(_ sender: UITextField) {
        print(sender.text!)
        if !(restaurnatEmailTextFie.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!
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

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

