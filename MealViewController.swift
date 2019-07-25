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

class MealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,MealDelegate ,UpdateMealDelegate ,UISearchBarDelegate{
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let mealResuableIdentifier : String = "cell2"
    var meals : Array<Meal> = []
    var mealList : Array<Meal> = []
    var filteredMeals : Array<Meal> = []
    var restaurantId :Int?
    var page: Int = 1
    var loadingMealFlag = true
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!
    let restaurant: Resturant = UserStoredData.returnUserDefaults()!
    var searchBarIsActive = false
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(pageNum: page)
        //  print("count : \(meals.count)")
        // tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        navigationBar.title = UserStoredData.returnUserDefaults()?.name
        
        //  mealList = meals
        searchBar.delegate = self
        
    }
    func sortList()
    {
        meals.sort(by: { $0.mealId! >
            $1.mealId!})
    }
    func loadData(pageNum:Int)
    {
        
            SVProgressHUD.show()
            MealDAO.getMeals(resturantId: restaurant.restaurantId! ,pageNum: pageNum ){
                (mealList)
                in
                
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    if !mealList.isEmpty
                    {
                        self.meals.append(contentsOf: mealList)
                        print ("meals here")
                        print(self.meals)
                        self.sortList()
                        self.tableView.reloadData()
                    }
                    else
                    {
                        self.loadingMealFlag = false
                    }
                    
                }
            }
        
        SVProgressHUD.dismiss()
        
    }
    
    func addMeal( meal: Meal) {
        meals.append(meal)
        sortList()
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
        if searchBarIsActive  && (filteredMeals.count != 0 ) {
            return filteredMeals.count
        }
        
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: mealResuableIdentifier)! as! MealTableViewCell
        //cell.imageView?.image = UIImage(named: meals[indexPath.row].image!)
        
        print(meals[indexPath.row].name!)
        if searchBarIsActive  && (filteredMeals.count != 0 ){
            mealList = filteredMeals
            
        }
        else{
            
            if indexPath.row == meals.count - 1
            {
                if self.loadingMealFlag
                {
                    print("enter")
                page = page + 1
                loadData(pageNum: page)
                }
            }
            mealList = meals
        }
        print("mealList out ")
        print(mealList)
        cell.mealNameLabel?.text = mealList[indexPath.row].name
        if let image = mealList[indexPath.row].image, !image.isEmpty {
            cell.mealPriceLabel?.text = String( describing: mealList[indexPath.row].price!)
            cell.mealImageView.sd_setShowActivityIndicatorView(true)
            cell.mealImageView.sd_setIndicatorStyle(.gray)
            cell.mealImageView.sd_setImage(with: URL(string: ImageAPI.getImage(type: .original, publicId: image)), completed: nil)
            
        }
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MealDAO.deleteMeal(rest_id: (UserStoredData.returnUserDefaults()?.restaurantId!)!, meal_id: meals[indexPath.row].mealId!)
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarIsActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBarIsActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMeals = meals.filter({(meal) ->Bool in
            let txt: NSString = meal.name! as NSString
            let range = txt.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        self.tableView.reloadData()
        
    }
}
