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
    var searchText: UITextField?
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        var ingredientStr = searchText?.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(ingredientStr!.isEmpty){
            let alert = UIAlertController(title: "Empty Ingredients", message: "Please put in ingredients before searching", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            apiManager.loadData(ingredientsQuery: ingredientStr!)
        }
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
        return searchedRecipes.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
            searchText = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
            searchText!.placeholder = "Lookup by ingredients (peppers, garlic, etc.)"
            searchText!.layer.borderColor = UIColor.lightGray.cgColor
            searchText!.layer.borderWidth = 1
            cell.addSubview(searchText!)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedCell", for: indexPath) as! SearchedRecipeTableViewCell
        
        let recipe: SearchedRecipe
        recipe = searchedRecipes[indexPath.row-1]
        cell.textView.text = recipe.title
        
        let url = URL(string: recipe.image)
        let data = try? Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data: data!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let searchedRecipe = searchedRecipes[indexPath.row-1]
        if let url = URL(string: searchedRecipe.href) {
            UIApplication.shared.open(url)
        }
        
    }
}
