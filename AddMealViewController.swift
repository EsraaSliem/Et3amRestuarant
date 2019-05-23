//
//  AddMealViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/22/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class AddMealViewController: UIViewController ,UINavigationControllerDelegate ,UIImagePickerControllerDelegate , UITextFieldDelegate{

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         priceTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            mealImage.image = image
        }
        else
        {
         print("error")
        }
         self.dismiss(animated: true, completion: nil)
       
        
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    
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
    @IBAction func uploadImage(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
 
    @IBAction func add(_ sender: Any)
    {
          print((nameTextField.text)!)
        let parameters : [String:Any] = [
            
            "mealName" :  (nameTextField.text)! ,
            "mealValue" :  Double((priceTextField.text)!)! ,
            "mealImage" : "image"
        ]
        
        MealDAO.addMeal(parameters: parameters, restaurantId: 1)
    }
   
}
