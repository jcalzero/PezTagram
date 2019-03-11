//
//  UserPostViewController.swift
//  PezTagram
//
//  Created by Julien Calfayan on 3/5/19.
//  Copyright © 2019 Julien Calfayan. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class UserPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var captionTextField: UITextView!
    @IBOutlet var imagePost: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onCamera(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            picker.sourceType = UIImagePickerController.SourceType.camera
            self.present(picker, animated: true, completion: nil)
        } else {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            let size = CGSize(width: 250, height: 250)
            let scaledImage = image.af_imageAspectScaled(toFill: size)
            
            imagePost.image = scaledImage
            
            dismiss(animated: true, completion: nil)
        } else {
            print("Error bringing picture up...")
        }
        
    }
    
    @IBAction func onPost(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = captionTextField.text!
        post["author"] = PFUser.current()!
        
        let imageData = imagePost.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground() { (success, error) in
            if success {
                _ = self.navigationController?.popToRootViewController(animated: true)
                print("Post Saved!")
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
