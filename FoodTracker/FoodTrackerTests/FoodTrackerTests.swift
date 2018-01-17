//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Srushti Ruparel on 10/1/18.
//  Copyright © 2018 Srushti Ruparel. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal class tests
    
    //Confirm that meal initializer returns a meal object when passed a valid parameters
    func testMealInitializationSucceeds() {
        
        //Zero rating
        let zeroRatiingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatiingMeal)
        
        //Highest Positive rating
        let positingRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positingRatingMeal)
    }
    
    //Confirm that meal initializer returns a nil when passed a negative rating or empty name
    func testMealInitializattionFails() {
        
        //Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //Empty rating
        let emptyRatingMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyRatingMeal)
        
        //Large rating
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
    
    
}
