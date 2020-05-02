//
//  DetailedRecipeViewController.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 4/30/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class DetailedRecipeViewController: UIViewController {
    var recipe: Recipe?
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var stepsTextField: UITextView!
    @IBOutlet weak var ingredientsTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitle.text = recipe!.title
        ingredientsTextField.layer.borderColor = UIColor.lightGray.cgColor
        ingredientsTextField.layer.borderWidth = 1.0
        ingredientsTextField.text = recipe!.ingredients
        stepsTextField.layer.borderColor = UIColor.lightGray.cgColor
        stepsTextField.layer.borderWidth = 1.0
        stepsTextField.text = recipe!.steps
        
    
        // Do any additional setup after loading the view.
    }
    
    func setRecipe(_recipe: Recipe){
        self.recipe = _recipe
        //recipeTitle.text = recipe!.title
//        ingredientsTextField.layer.borderColor = UIColor.lightGray.cgColor
//        ingredientsTextField.layer.borderWidth = 1.0
//        ingredientsTextField.text = recipe!.ingredients
//        stepsTextField.layer.borderColor = UIColor.lightGray.cgColor
//        stepsTextField.layer.borderWidth = 1.0
//        stepsTextField.text = recipe!.steps
    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
//
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
//        }
//        
//        
//        switch indexPath.section{
//        case 0:
//            cell!.textLabel?.text = recipe.title
//        case 1:
//            cell!.textLabel?.text = recipe.ingredients
//            cell!.textLabel?.numberOfLines = 0
//        case 2:
//            cell!.textLabel?.text = recipe.steps
//            cell!.textLabel?.numberOfLines = 0
//        case 3:
//            cell?.imageView?.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
//            cell!.imageView?.image = ImageResourceManager.sharedInstance.getSavedImage(name: recipe.title)
//        default:
//            break;
//        }
//        return cell!
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        var title = ""
//        
//        switch section {
//        case 0:
//            title = "Title: "
//        case 1:
//            title = "Ingredients: "
//        case 2:
//            title = "Steps: "
//        case 3:
//            title = ""
//        default:
//            break;
//        }
//        
//        return title
//    }

}
