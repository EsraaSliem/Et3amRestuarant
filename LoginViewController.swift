//
//  LoginViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/17/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var restaurnatEmailTextFie: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.layer.masksToBounds = true
        
    }
    
    
    // MARK: - Handler
    
    @IBAction func login(_ sender: Any) {
        
        SVProgressHUD.show()
        ResturantDAO.login(email: restaurnatEmailTextFie.text!, pass:passwordTextField.text!){
            
            (code) in
            SVProgressHUD.dismiss()
            if  (code == 1)
            {
                
                print("enter")
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabView")
                appDelegate.window?.rootViewController = initialViewController
                appDelegate.window?.makeKeyAndVisible()
            }
            else
            {
                //SVProgressHUD.showError(withStatus: "invalid email or password")
                self.showToast(message: "invalid email or password")
            }
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
    
    
    
}

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

