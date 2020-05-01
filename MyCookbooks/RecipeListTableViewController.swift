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
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "recipe")
        let recipe: Recipe
        recipe = recipeDb.recipeList[indexPath.row]
        cell.textLabel?.text = recipe.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recipe = recipeDb.recipeList[indexPath.row]
        print("Clicked \(recipe.title)")

        let detailVC = DetailedRecipeViewController(style: .grouped)
        detailVC.recipe = recipe
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}