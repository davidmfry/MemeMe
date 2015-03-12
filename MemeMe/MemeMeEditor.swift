//
//  ViewController.swift
//  MemeMe
//
//  Created by David on 3/10/15.
//  Copyright (c) 2015 David Fry. All rights reserved.
//

import UIKit

class MemeMeEditor: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{

    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    @IBOutlet weak var topTabBar: UIToolbar!
    @IBOutlet weak var bottomTabBar: UIToolbar!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    var viewWidth: CGFloat?
    var viewHeight: CGFloat?
    var viewX: CGFloat?
    var viewY: CGFloat?
    
    var memeImage: UIImage?

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.topTextfield.delegate = self
        self.bottomTextfield.delegate = self
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.actionButton.enabled = false
        
        
        
        // Getting the view diminsions to movie up and down with the keyboard
        self.viewWidth = self.view.frame.width
        self.viewHeight = self.view.frame.height
        self.viewX = self.view.frame.origin.x
        self.viewY = self.view.frame.origin.y
        
        
        
 
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if !checkForCamera()
        {
            self.cameraBarButton.enabled = false
        }
        
//        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
//        self.unsubscribeFromKeyboardNotifications()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
//MARK: Delegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.image = image
        self.actionButton.enabled = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        if textField == self.bottomTextfield
        {
            // Moves the view out of the way for the text fields
            var textFieldPadding: CGFloat = 300.0
            var currentWidth = self.view.bounds.width
            var currentHeight = self.view.bounds.height
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                var newY = self.view.bounds.origin.y + textField.frame.origin.y - textFieldPadding
                var currentX = self.view.bounds.origin.x
                println(newY)
                self.view.bounds = CGRect(x: currentX, y: newY, width: currentWidth, height: currentHeight)
            })
        }
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.bounds = CGRect(x: self.viewX!, y: self.viewY!, width: self.viewWidth!, height: self.viewHeight!)
        })
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        // Dissmiss the keyboard when the view is touched
        self.view.endEditing(true)
    }
    
    
    
    
//MARK: IBActions
    @IBAction func actionButtonPressed(sender: UIBarButtonItem)
    {
        
        self.memeImage = generateMemedImage()
        self.saveMeme(self.memeImage!)
        let activityViewController = UIActivityViewController(activityItems: [self.memeImage!], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true) { () -> Void in
        }
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cameraButtonPressed(sender: UIBarButtonItem)
    {
        self.presentImagePicker("camera")
    }
    
    @IBAction func albumButtonPressed(sender: UIBarButtonItem)
    {
        self.presentImagePicker("photo-libary")
    }
    
    
//MARK: Notifications
//    func subscribeToKeyboardNotifications()
//    {
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
//    }
//    
//    func unsubscribeFromKeyboardNotifications()
//    {
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
//    }
    
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
    
    
    func keyboardWillShow(notification: NSNotification)
    {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue
        return keyboardSize.CGRectValue().height
    }

    func saveMeme(memedImage: UIImage)
    {
        var newMeme = Meme(topTitle: self.topTextfield.text!, bottomTitle: self.bottomTextfield.text!, image: self.imageView.image!, memedImage: memedImage)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        appDelegate.memes.append(newMeme)

    }
    
    func generateMemedImage() -> UIImage
    {
        // Hide tabbars
        self.topTabBar.hidden = true
        self.bottomTabBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show tabbars
        self.topTabBar.hidden = false
        self.bottomTabBar.hidden = false
        
        return memedImage
    }
    
    
    
    
    
    
    
}

