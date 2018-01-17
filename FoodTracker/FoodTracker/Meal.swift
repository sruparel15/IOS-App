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
    var photo: UIImage?
    var rating: Int
    let ref: DatabaseReference?
   // var key: String
    
    //Mark: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        
        //Initialization should fail if there is no name or if the rating is negative
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
        self.ref = nil
        
    }

    init?(snapshot: DataSnapshot) {
        //key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        photo = snapshotValue["image"] as? UIImage
        rating = snapshotValue["rating"] as! Int
        ref = snapshot.ref
        
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "image": photo,
            "rating": rating
        ]
    }
}
