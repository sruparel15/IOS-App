//
//  Meal.swift
//  FoodTracker
//
//  Created by Srushti Ruparel on 15/1/18.
//  Copyright © 2018 Srushti Ruparel. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Meal {
    
    //MARK: Properties
    var name: String = ""
    var photoUrl: String?
    var rating: Int
    let id: String
    
    //Mark: Initialization
    init?(name: String, photoUrl: String, rating: Int, id: String) {
        
        //Initialization should fail if there is no name or if the rating is negative
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photoUrl = photoUrl
        self.rating = rating
        self.id = id
    }

    init?(snapshot: DataSnapshot) {
        //key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        photoUrl = snapshotValue["image"] as? String
        rating = snapshotValue["rating"] as! Int
        id = snapshotValue["id"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "image": photoUrl!,
            "rating": rating,
            "id": id
        ]
    }
}
