//
//  Cocktail.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/3/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import Foundation

class Cocktail{
    var id: Int
    var title: String
    var ingredients: String
    var image: String
    
    init(id: Int, title: String, ingredients: String, image: String){
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.image = image
    }
    
}
