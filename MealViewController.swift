//
//  MealViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
class MealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,MealDelegate ,UpdateMealDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let mealResuableIdentifier : String = "cell2"
    var meals : Array<Meal> = []
    var restaurantId :Int?
    let restaurant: Resturant = UserStoredData.returnUserDefaults()
 
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
                loadData()
        //  print("count : \(meals.count)")
        // tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        titleLabel.text = UserStoredData.returnUserDefaults().name!

        
    }
    func loadData()
    {
        
        SVProgressHUD.show()
        MealDAO.getMeals(resturantId: restaurant.restaurantId! ){
            (mealList)
            in
         
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.meals = mealList
                self.tableView.reloadData()
            }
        }
        SVProgressHUD.dismiss()

    }
    
    func addMeal( meal: Meal) {
        meals.append(meal)
        self.tableView.reloadData()
    }
    func updateMeal(updatedMeal :Meal)
    {
        print("update")
        for i in 0..<meals.count
        {
            print(i)
            if updatedMeal.mealId == meals[i].mealId
            {
                print("checkkkk")
                meals[i].image = updatedMeal.image
                
                meals[i].name = updatedMeal.name
                meals[i].price = updatedMeal.price
                tableView.reloadData()
                break
            }
        }
    }
    
    // MARK: - Handler
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count : \(meals.count)")
        return meals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: mealResuableIdentifier)! as! MealTableViewCell
        //cell.imageView?.image = UIImage(named: meals[indexPath.row].image!)
        
        cell.mealNameLabel?.text = meals[indexPath.row].name
        print(meals[indexPath.row].name!)
        
        if let image = meals[indexPath.row].image, !image.isEmpty {
            cell.mealPriceLabel?.text = String( describing: meals[indexPath.row].price!)
            cell.mealImageView.sd_setShowActivityIndicatorView(true)
            cell.mealPriceLabel?.text = String( describing: meals[indexPath.row].price!)
            cell.mealImageView.sd_setIndicatorStyle(.gray)
            cell.mealPriceLabel?.text = String( describing: meals[indexPath.row].price!)
            cell.mealImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .original, publicId: image)), completed: nil)
            
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            MealDAO.deleteMeal(rest_id: UserStoredData.returnUserDefaults().restaurantId!, meal_id: meals[indexPath.row].mealId!)
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updateViewController = self.storyboard?.instantiateViewController(withIdentifier: "updateMeal") as! UpdateMealViewController
        updateViewController.meal = meals[indexPath.row]
        updateViewController.delegate = self
        self.navigationController?.pushViewController(updateViewController, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddMealViewController
        vc.delegate = self
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        UserStoredData.removeUserDefaults()
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        
        self.present(loginVC, animated: true, completion: nil)
    }
}
