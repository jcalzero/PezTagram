//
//  SignUpViewController.swift
//  PezTagram
//
//  Created by Julien Calfayan on 3/4/19.
//  Copyright © 2019 Julien Calfayan. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var usernameSignUp: UITextField!
    @IBOutlet var passwordSignUp: UITextField!
    @IBOutlet var emailSignUp: UITextField!
    @IBOutlet var bioSignUp: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*@IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 250, height: 250)
        let scaledImage = image.af_imageScaled(to: size)
        
        profilePictureSignUp.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }*/
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameSignUp.text
        user.password = passwordSignUp.text
        user.email = emailSignUp.text
        
        user["bio"] = bioSignUp.text
                
        user.signUpInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
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
