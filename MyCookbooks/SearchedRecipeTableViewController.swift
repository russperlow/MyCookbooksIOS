//
//  SearchedRecipeTableViewController.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/1/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

protocol SearchedRecipeDelegate {
    func didCompleteRequest(searchedRecipes: [SearchedRecipe])
}


class SearchedRecipeTableViewController: UITableViewController, SearchedRecipeDelegate {

    let apiManager = RestApiManager()
    var searchedRecipes = [SearchedRecipe]()
    
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        apiManager.loadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.delegate = self
    }
    
    func didCompleteRequest(searchedRecipes: [SearchedRecipe]) {
        print("didCompleteRequest \(searchedRecipes)")
        self.searchedRecipes = searchedRecipes
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
        return searchedRecipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "recipe")
        let recipe: SearchedRecipe
        recipe = searchedRecipes[indexPath.row]
        cell.textLabel?.text = recipe.title
        return cell
    }

}
