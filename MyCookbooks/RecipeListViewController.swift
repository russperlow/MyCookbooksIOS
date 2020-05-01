//
//  RecipeListViewController.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 4/30/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var recipeDb = RecipeDb.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDb.readValues()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDb.recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let recipe: Recipe
        recipe = recipeDb.recipeList[indexPath.row]
        cell.textLabel?.text = recipe.title
        return cell
    }
    
}

