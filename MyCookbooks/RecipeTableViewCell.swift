//
//  RecipeTableViewCell.swift
//  MyCookbooks
//
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

 
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
