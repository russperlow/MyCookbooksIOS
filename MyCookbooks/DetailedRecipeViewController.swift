//
//  DetailedRecipeViewController.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 4/30/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class DetailedRecipeViewController: UITableViewController {

    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
        
        switch indexPath.section{
        case 0:
            cell!.textLabel?.text = recipe.title
        case 1:
            cell!.textLabel?.text = recipe.ingredients
            cell!.textLabel?.numberOfLines = 0
        case 2:
            cell!.textLabel?.text = recipe.steps
            cell!.textLabel?.numberOfLines = 0
        case 3:
            cell!.imageView?.image = ImageResourceManager.sharedInstance.getSavedImage(name: recipe.title)
        default:
            break;
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title = ""
        
        switch section {
        case 0:
            title = "Title: "
        case 1:
            title = "Ingredients: "
        case 2:
            title = "Steps: "
        case 3:
            title = ""
        default:
            break;
        }
        
        return title
    }

}
