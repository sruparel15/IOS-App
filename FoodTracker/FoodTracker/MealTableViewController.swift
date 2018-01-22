//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Srushti Ruparel on 15/1/18.
//  Copyright © 2018 Srushti Ruparel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MealTableViewController: UITableViewController {

    var meals = [Meal]()
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference(withPath: "meals")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMealsFromDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        //statement for indexpath and assigning
       
        cell.nameLabel.text = meals[indexPath.row].name
       // cell.photoImageView.image = meals[indexPath.row].photo
        cell.ratingControl.rating = meals[indexPath.row].rating
        
        if let imageUrl = meals[indexPath.row].photoUrl {
            URLSession.shared.dataTask(with: URL(string: imageUrl)!, completionHandler:
                    { (data, response, error) in
                        if error != nil {
                            print(error)
                            return
                        }
                        DispatchQueue.main.async {
                            cell.photoImageView.image = UIImage(data: data!)
                        }
                }).resume()
        }
        return cell
    }
    
    private func loadMealsFromDatabase() {
        databaseRef.observe(.value) { snapshot in
            var newItems: [Meal] = []
            
            for item in snapshot.children {
                let meal = Meal(snapshot: item as! DataSnapshot)
                newItems.append(meal!)
            }
            
            self.meals = newItems
            self.tableView.reloadData()
        }
    }
}
