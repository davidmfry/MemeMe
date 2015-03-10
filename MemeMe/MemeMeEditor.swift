//
//  ViewController.swift
//  MemeMe
//
//  Created by David on 3/10/15.
//  Copyright (c) 2015 David Fry. All rights reserved.
//

import UIKit

class MemeMeEditor: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
 
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if !checkForCamera()
        {
            self.cameraBarButton.enabled = false
        }
    }

//MARK: Delegate Methods
    
    
//MARK: IBActions
    @IBAction func actionButtonPressed(sender: UIBarButtonItem)
    {
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem)
    {
        
    }
    
    @IBAction func cameraButtonPressed(sender: UIBarButtonItem)
    {
        self.presentImagePicker("camera")
    }
    
    @IBAction func albumButtonPressed(sender: UIBarButtonItem)
    {
        self.presentImagePicker("photo-libary")
    }
//MARK: Helper function
    func checkForCamera() -> Bool
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            return true
        }
        else
        {
            println("No device found")
            return false
        }
    }
    
    func presentImagePicker(pickerType: String)
    {
        
        if self.checkForCamera() && pickerType == "camera"
        {
            self.presentViewController(self.createImageController(.Camera), animated: true, completion: nil)
        }
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) && pickerType == "photo-libary"
        {
            self.presentViewController(self.createImageController(.PhotoLibrary), animated: true, completion: nil)
        }
    }
    
    func createImageController(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    
    
    
    
    
}

