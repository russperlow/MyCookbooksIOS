//
//  SearchedRecipeTableViewCell.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/1/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class SearchedRecipeTableViewCell: UITableViewCell {


    
    @IBOutlet weak var searchedImageView: UIImageView!
    @IBOutlet weak var textView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
