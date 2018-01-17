//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Srushti Ruparel on 12/1/18.
//  Copyright © 2018 Srushti Ruparel. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //Mark: Properties
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet {
            setUpButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setUpButtons()
        }
    }
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectedStates()
        }
    }

    //Mark: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
    
        //Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //If the selected star represents the current rating, rese the rating to 0.
            rating = 0
        } else {
            //Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setUpButtons() {
        
        //Clear any existing button
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
        //Create a button
        let button = UIButton()
        button.setImage(emptyStar, for: .normal)
        button.setImage(filledStar, for: .selected)
        button.setImage(highlightedStar, for: .highlighted)
        button.setImage(highlightedStar, for: [.highlighted, .selected])
        
        //Add contraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        //Set the accessibilty label
        button.accessibilityLabel = "Set \(index + 1) star rating"
            
        //Set up the button action
         button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        //Add the button to the stack
        addArrangedSubview(button)
            
        //Add new button to the rating button array
        ratingButtons.append(button)
        }
        
        updateButtonSelectedStates()
    }
    
    private func updateButtonSelectedStates() {
        for(index, button) in ratingButtons.enumerated() {
            //If the index of the button is less than rating, that button should be selected.
            button.isSelected = index < rating
            
            //Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            } else {
                hintString = nil
            }
            
            //Calculate the value string
            let valueString: String
            switch(rating) {
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) star set"
            }
            
            //Assign the value string and hint string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
