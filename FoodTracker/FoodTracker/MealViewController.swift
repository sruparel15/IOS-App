//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Srushti Ruparel on 10/1/18.
//  Copyright © 2018 Srushti Ruparel. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    var databaseRef: DatabaseReference! {
        return Database.database().reference(withPath: "meals")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //The info dictionary may contain multiple representation of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image but was provided the following: \(info)")
        }
        
        //Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        //Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: NAvigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets the user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure the view controller is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        addMeal()
        dismiss(animated: true, completion: nil)
    }
    
    func addMeal() {
        let key = databaseRef.childByAutoId().key
        let newMeal: [String: Any] = [
            "id": key,
            "name": nameTextField.text!,
            "image": "image1",
            "rating": ratingControl.rating
        ]
        
        databaseRef.child(key).setValue(newMeal)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }

}

