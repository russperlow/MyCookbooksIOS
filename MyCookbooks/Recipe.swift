//
//  Recipe.swift
//  MyCookbooks
//
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import Foundation

class Recipe{
    var id: Int
    var title: String
    var ingredients: String
    var steps: String
    var image: String
    
    init(id: Int, title: String, ingredients: String, steps: String, image: String){
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.steps = steps
        self.image = image
    }
    
}
