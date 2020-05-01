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
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedCell", for: indexPath) as! SearchedRecipeTableViewCell
        
        let recipe: SearchedRecipe
        recipe = searchedRecipes[indexPath.row]
        cell.textView.text = recipe.title
        
        let url = URL(string: recipe.image)
        let data = try? Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data: data!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let searchedRecipe = searchedRecipes[indexPath.row]
        if let url = URL(string: searchedRecipe.href) {
            UIApplication.shared.open(url)
        }
        
    }
}
