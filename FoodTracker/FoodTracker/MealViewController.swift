//
//  MealViewController.swift
//  FoodTracker
//
//  Created by 姚骥迁 on 11/24/15.
//  Copyright © 2015 BigBit Corp. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal : Meal?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through the delegate callback
        nameTextField.delegate = self
        
        /*
        nameTextField.text = meal?.name
        if let img = meal?.photo {
            photoImageView.image = img
        }
        ratingControl.rating = (meal?.rating)!
        */
        if let theMeal = meal{
            navigationItem.title = theMeal.name
            nameTextField.text = theMeal.name
            photoImageView.image = theMeal.photo
            ratingControl.rating = theMeal.rating
        }
        checkValidMealName()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkValidMealName(){
        let mealName = nameTextField.text ?? ""
        saveButton.enabled = !mealName.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = nameTextField.text
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user cancelled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // The 
        let selectedImage = image
        photoImageView.image = selectedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddModel = presentingViewController is UINavigationController
        if isPresentingInAddModel {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            navigationController!.popToRootViewControllerAnimated(true)
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(saveButton === sender){
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the Keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a View Controller that lets the user pick media from the PhotoLibrary.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photo to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure the ViewController is notified when the picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
}

