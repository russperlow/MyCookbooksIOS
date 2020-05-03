//
//  DetailedCocktailViewController.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/3/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//
import UIKit

class DetailedCocktailViewController: UIViewController {
    var cocktail: Cocktail?
    
    @IBOutlet weak var cocktailTitle: UILabel!
    @IBOutlet weak var cocktailIngredients: UITextView!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func trashButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Confirmation", message: "Are you sure you would like to delete \(cocktail!.title)?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
            self.deleteCocktail()

        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteCocktail(){
        CocktailDb.sharedInstance.deleteCocktail(id: self.cocktail!.id)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailTitle.text = cocktail!.title
        cocktailIngredients.layer.borderColor = UIColor.lightGray.cgColor
        cocktailIngredients.layer.borderWidth = 1.0
        cocktailIngredients.text = cocktail!.ingredients
        imageView.image = ImageResourceManager.sharedInstance.getSavedImage(name: cocktail!.title)
    
    }
}
