//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Srushti Ruparel on 15/1/18.
//  Copyright © 2018 Srushti Ruparel. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //MARK: Propereties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
