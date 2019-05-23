//
//  MealViewController.swift
//  Et3amRestaurant
//
//  Created by Esraa Sliem on 5/15/19.
//  Copyright © 2019 Jets39. All rights reserved.
//

import UIKit
import Alamofire

class MealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        getMeals(resturantId:restaurantId!)
        
        //  print("count : \(meals.count)")
        // tableView.reloadData()
        
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
    public   func getMeals( resturantId : Int )
        
    {
        //     var meals : Array<Meal> = []
        let url : String = Et3amRestuarantAPI.restaurantBaseURL+String(resturantId)+MealURLs.allMeals.rawValue
        Alamofire.request(url).responseJSON {
            response in
            switch response.result {
            case .success:
                do{
                    
                    let data = response.data
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<NSDictionary>
                    print(json)
                    //  let results =  json["restaurant"] as! Array< NSDictionary >
                    
                    for i in json
                    {
                        var meal : Meal = Meal()
                        meal.mealId = i["mealId"] as?  Int
                        print(meal.mealId! )
                        meal.name = i["mealName"] as?  String
                        meal.price = i["mealValue"] as?  Double
                        meal.image = i["mealImage"] as?  String
                        print(meal.name)
                        self.meals.append(meal)
                        
                    }
                    self.tableView.reloadData()
                } catch
                {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                
            }
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updateViewController = self.storyboard?.instantiateViewController(withIdentifier: "updateMeal") as! UpdateMealViewController
        updateViewController.meal = meals[indexPath.row]
        self.navigationController?.pushViewController(updateViewController, animated: true)
        
    }
    
}
