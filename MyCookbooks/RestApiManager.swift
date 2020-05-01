//
//  ApiManager.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/1/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import Foundation



class RestApiManager: NSObject {
    
    var responseData: Data?
    var urlString = ""
    var delegate: SearchedRecipeDelegate?
    
    override init() {
        urlString = "http://www.recipepuppy.com/api/?i=peppers"
    }
    
    func loadData(){
        let session = URLSession.shared
        let task = session.dataTask(with: URL(string: urlString)!){
            (data, response, error) in

            self.responseData = data
            let searchedRecipies = self.parseData()
            self.delegate!.didCompleteRequest(searchedRecipes: searchedRecipies)
            DispatchQueue.main.async {
                
            }
        }
        
        task.resume()
    }
    
    func parseData() ->  [SearchedRecipe]{
        let json: [String: Any] = try! JSONSerialization.jsonObject(with: responseData!, options: []) as! [String : Any]

        let results = json["results"] as! [[String:Any]]
        var searchedRecipes = [SearchedRecipe]()
        
        for result in results {
            let title = result["title"] as! String
            let ingredients = result["ingredients"] as! String
            let href = result["href"] as! String
            let image = result["thumbnail"] as! String
            
            searchedRecipes.append(SearchedRecipe(title: title, ingredients: ingredients, href: href, image: image))
        }
        
        print(searchedRecipes)
        return searchedRecipes
    }
    
}
