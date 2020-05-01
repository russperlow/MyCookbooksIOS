//
//  SearchedRecipe.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/1/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import Foundation

struct SearchedRecipe {
    let title: String
    let ingredients: String
    let href: String
    let image: String
    
}

extension SearchedRecipe{
    init?(json: [String: Any]){
        guard let title = json["title"] as? String,
            let ingredients = json["ingredients"] as? String,
            let href = json["href"] as? String,
            let image = json["thumbnail"] as? String
            else{
                return nil
        }
        
        self.title = title
        self.ingredients = ingredients
        self.href = href
        self.image = image
    }
}
