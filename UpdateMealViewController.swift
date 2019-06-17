//
//  UpdateMealViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/23/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit

class UpdateMealViewController: UIViewController ,UINavigationControllerDelegate ,UIImagePickerControllerDelegate ,
UITextFieldDelegate{
    
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var mealName: UITextField!
    var delegate : UpdateMealDelegate?
    var meal : Meal?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        priceTextField.delegate = self
        priceTextField.text =  String( describing: meal!.price!)
        mealName.text = meal?.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
        
    }
    @IBAction func changeImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
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
    @IBAction func updateMeal(_ sender: UIButton) {
        let parameters : [String:Any] = [
            
            "mealName" :  (mealName.text)! ,
            "mealValue" :  Double((priceTextField.text)!)! ,
            "mealImage" : "image"
        ]
        MealDAO.updateMeal(parameters: parameters, rest_id: UserStoredData.returnUserDefaults().restaurantId!, meal_id: (meal?.mealId)!) {
            (updatedMeal) in
            DispatchQueue.main.async {
                
                print("hhh")
                
                self.delegate?.updateMeal(updatedMeal: updatedMeal)
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }
        
        
    }
    
    
    
}

