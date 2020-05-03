//
//  CocktailListTableViewController.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/3/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class CocktailListTableViewController: UITableViewController {

    var cocktailDb = CocktailDb.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()


        cocktailDb.readValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cocktailDb.readValues()
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
        return cocktailDb.cocktailList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktail", for: indexPath) as! CocktailTableViewCell
        let cocktail: Cocktail = cocktailDb.cocktailList[indexPath.row];

        cell.cocktailTitle.text = cocktail.title
        
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 75, height: 75)

        let image = ImageResourceManager.sharedInstance.getSavedImage(name: cocktail.title)
        cell.cocktailImage?.clipsToBounds = true
        cell.cocktailImage?.image = image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cocktail = cocktailDb.cocktailList[indexPath.row]
        print("Clicked \(cocktail.title)")

        let detailVC = storyboard?.instantiateViewController(identifier: "DetailedCocktailViewController") as! DetailedCocktailViewController
        detailVC.cocktail = cocktail
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
