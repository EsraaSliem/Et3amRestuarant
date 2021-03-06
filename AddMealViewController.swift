//
//  AddMealViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/22/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SVProgressHUD
class AddMealViewController: UIViewController ,UINavigationControllerDelegate ,UIImagePickerControllerDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    var mealImageName: String?
    var delegate : MealDelegate?
    var isUploadImage : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            mealImage.image = image
            let imageData: Data = UIImageJPEGRepresentation(image, 0.2)!
            self.uploadMealImage(imageData)
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
    
    
    
    @IBAction func uploadImage(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any)
    {
        if(!(nameTextField.text?.isEmpty)! && !(priceTextField.text?.isEmpty)! && isUploadImage)
        {
            SVProgressHUD.show()
            let parameters : [String:Any] = [
                
                "mealName" :  (nameTextField.text)! ,
                "mealValue" :  Double((priceTextField.text)!)! ,
                "mealImage" : mealImageName!
            ]
            
            MealDAO.addMeal(parameters: parameters, restaurantId: 1){
                (id) in
                SVProgressHUD.dismiss()
                if (id != nil)  {
                    print("kkk")
                    var newMeal : Meal = Meal()
                    newMeal.name = (self.nameTextField.text)!
                    newMeal.price = Double((self.priceTextField.text)!)!
                    newMeal.mealId = id!
                    newMeal.image = self.mealImageName!
                    print(newMeal)
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        self.delegate?.addMeal(meal: newMeal)
                        
                        
                    }
                }
            }
            
            
        }
        else{
            SVProgressHUD.showError(withStatus: "please, fill all data")
        }
    }
    func uploadMealImage(_ imageData: Data) {
        //   self.uploadStarts()
        ImageAPI.uploadImage(imgData: imageData, completionHandler: { result in
            
            //     self.uploadCompleted()
            
            if let _ = result.0, let publicId = result.1 {
                self.mealImageName = publicId
                self.isUploadImage = true
            }
        })
    }
    
}
