//
//  CocktailTableViewCell.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/3/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

 
    @IBOutlet weak var cocktailImage: UIImageView!
    
    @IBOutlet weak var cocktailTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
