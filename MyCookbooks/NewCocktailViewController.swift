//
//  NewCocktailViewController.swift
//  MyCookbooks
//
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import UIKit

class NewCocktailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    @IBOutlet weak var uploadImageView: UIImageView!
//
//    @IBOutlet weak var cocktailTitle: UITextField!
//    @IBOutlet weak var cocktailIngredients: UITextView!
//    @IBOutlet weak var cocktailSteps: UITextView!
    @IBOutlet weak var uploadImageView: UIImageView!
    
    @IBOutlet weak var cocktailTitle: UITextField!
    
    @IBOutlet weak var cocktailIngredients: UITextView!
    
    var cocktailDb = CocktailDb.sharedInstance
    var imageSelected = false
    var imageResourceManager = ImageResourceManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailIngredients.layer.borderColor = UIColor.lightGray.cgColor
        cocktailIngredients.layer.borderWidth = 1
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewCocktail(_ sender: Any) {
        
        if(cocktailTitle.text?.isEmpty ?? false || cocktailIngredients.text.isEmpty){
            
            let alert = UIAlertController(title: "Empty Fields", message: "Please make sure all fields are filled", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else if(!imageSelected){
            let alert = UIAlertController(title: "Missing Image", message: "Please add an image to continue", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{

            let imageSaved = imageResourceManager.saveImage(image: uploadImageView.image!, imageTitle: cocktailTitle.text!)
            
            if(imageSaved){
            
                cocktailDb.insertCocktail(title: cocktailTitle.text!, ingredients: cocktailIngredients.text, image: cocktailTitle.text!)
                navigationController?.popViewController(animated: true)
            }else{
                let alert = UIAlertController(title: "Error Saving Image", message: "Please try again. Choose another image if this continues.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
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
    
}
