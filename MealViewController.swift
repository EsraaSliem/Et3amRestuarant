//
//  MealViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import Alamofire

class MealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,MealDelegate ,UpdateMealDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let mealResuableIdentifier : String = "cell2"
    var meals : Array<Meal> = []
    var restaurantId :Int?
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        restaurantId = UserDefaults.standard.integer(forKey: "restaurantAdminId")
        print(restaurantId!)
        MealDAO.getMeals(resturantId: restaurantId! ){
            (mealList) in
            
            DispatchQueue.main.async {
                self.meals = mealList
                self.tableView.reloadData()
            }
        }
        
        //  print("count : \(meals.count)")
        // tableView.reloadData()
        
    }
    func addMeal() {
        
        self.tableView.reloadData()
    }
    func updateMeal(updatedMeal :Meal)
    {
        for i in 0..<meals.count
        {
            if updatedMeal.mealId == meals[i].mealId
            {
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
        cell.mealPriceLabel?.text = String( describing: meals[indexPath.row].price!)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            MealDAO.deleteMeal(rest_id: 1, meal_id: meals[indexPath.row].mealId!)
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
    
}
