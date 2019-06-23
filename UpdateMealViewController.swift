//
//  UpdateMealViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa on 5/23/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
class UpdateMealViewController: UIViewController, UINavigationControllerDelegate,
UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    
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
        print(meal?.image!)
        if let image = meal?.image, !image.isEmpty {
            mealImage.sd_setShowActivityIndicatorView(true)
            mealImage.sd_setIndicatorStyle(.gray)
            mealImage.sd_setImage(with: URL(string: ImageAPI.getImage(type: .original, publicId: image)), completed: nil)
        }
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
            let imageData: Data = UIImageJPEGRepresentation(image, 0.2)!
            self.uploadMealImage(imageData)
        }
        else
        {
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    @IBAction func updateMeal(_ sender: UIButton) {
        if(!(priceTextField.text?.isEmpty)! && !(mealName.text?.isEmpty)!)
        {
            SVProgressHUD.show()
            let parameters : [String:Any] = [
                
                "mealName" :  (mealName.text)! ,
                "mealValue" :  Double((priceTextField.text)!)! ,
                "mealImage" : meal!.image
            ]
            print("mealImage"+meal!.image!)
            
            MealDAO.updateMeal(parameters: parameters, rest_id: UserStoredData.returnUserDefaults().restaurantId!, meal_id: (meal?.mealId)!) {
                (updatedMeal) in
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    
                    print("hhh")
                    
                    self.delegate?.updateMeal(updatedMeal: updatedMeal)
                    self.navigationController?.popViewController(animated: true)
                    
                }
                
            }
        }
        else {
            SVProgressHUD.showError(withStatus: "please fill data")
        }
        
    }
    func uploadMealImage(_ imageData: Data) {
        
        ImageAPI.uploadImage(imgData: imageData, completionHandler: { result in
            if let _ = result.0, let publicId = result.1 {
                self.meal!.image = publicId
            }
        })
    }
    
    
}

