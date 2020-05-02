//
//  RecipeListTableViewController.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 4/30/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UITableViewController {

    var recipeDb = RecipeDb.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()


        recipeDb.readValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeDb.readValues()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDb.recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe", for: indexPath) as! RecipeTableViewCell
        let recipe: Recipe = recipeDb.recipeList[indexPath.row];

        cell.recipeTitle.text = recipe.title
        
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 75, height: 75)

        let image = ImageResourceManager.sharedInstance.getSavedImage(name: recipe.title)
        cell.recipeImage?.clipsToBounds = true
        cell.recipeImage?.image = image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recipe = recipeDb.recipeList[indexPath.row]
        print("Clicked \(recipe.title)")

        let detailVC = storyboard?.instantiateViewController(identifier: "DetailedRecipeViewController") as! DetailedRecipeViewController
        detailVC.recipe = recipe
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
