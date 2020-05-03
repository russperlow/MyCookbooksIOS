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
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func trashButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Confirmation", message: "Are you sure you would like to delete \(recipe?.title)?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
            self.deleteRecipe()

        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteRecipe(){
        RecipeDb.sharedInstance.deleteRecipe(id: self.recipe!.id)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitle.text = recipe!.title
        ingredientsTextField.layer.borderColor = UIColor.lightGray.cgColor
        ingredientsTextField.layer.borderWidth = 1.0
        ingredientsTextField.text = recipe!.ingredients
        stepsTextField.layer.borderColor = UIColor.lightGray.cgColor
        stepsTextField.layer.borderWidth = 1.0
        stepsTextField.text = recipe!.steps
        imageView.image = ImageResourceManager.sharedInstance.getSavedImage(name: recipe!.title)
    
    }
}
