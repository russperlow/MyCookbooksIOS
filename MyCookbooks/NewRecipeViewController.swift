//
//  NewRecipeViewController.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 4/30/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class NewRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet weak var recipeSteps: UITextView!
    
    var recipeDb = RecipeDb.sharedInstance
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeIngredients.layer.borderColor = UIColor.lightGray.cgColor
        recipeSteps.layer.borderColor = UIColor.lightGray.cgColor
        recipeIngredients.layer.borderWidth = 1
        recipeSteps.layer.borderWidth = 1
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewRecipe(_ sender: Any) {
        
        if(recipeTitle.text?.isEmpty ?? false || recipeSteps.text.isEmpty || recipeIngredients.text.isEmpty){
            
            let alert = UIAlertController(title: "Empty Fields", message: "Please make sure all fields are filled", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else if(!imageSelected){
            let alert = UIAlertController(title: "Missing Image", message: "Please add an image to continue", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let imagePath = writeImageToDirectory(title: recipeTitle.text!)
            recipeDb.insertRecipe(title: recipeTitle.text!, ingredients: recipeIngredients.text, steps: recipeSteps.text, image: imagePath)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        uploadImageView.image = image
        
        imageSelected = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func writeImageToDirectory(title: String) -> String{
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(title).png")
        
        let data = uploadImageView.image!.pngData()
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        
        return imagePath as String
    }
    
}