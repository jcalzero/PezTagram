//
//  ProfileViewController.swift
//  PezTagram
//
//  Created by Julien Calfayan on 3/2/19.
//  Copyright © 2019 Julien Calfayan. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var bioTextView: UITextView!
    @IBOutlet var profilePicture: UIImageView!
    
    let user = PFUser.current()
    var posts = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        usernameLabel.text = user?.username
        
        bioTextView.text = user?["bio"] as? String
        
        let imageFile = user?["profilePicture"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        profilePicture.layer.cornerRadius = 50
        profilePicture.clipsToBounds = true
        profilePicture.af_setImage(withURL: url)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                // The request failed
                print(error.localizedDescription)
            } else {
                self.posts = posts!
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePostsCollectionViewCell", for: indexPath) as! ProfilePostsCollectionViewCell
        
        let post = posts[indexPath.row]
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.postImageView.af_setImage(withURL: url)
        
        return cell
    }
    
    @IBAction func setPictureButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 250, height: 250)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profilePicture.image = scaledImage
        
        let imageData = profilePicture.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        user?["profilePicture"] = file
        
        user?.saveInBackground() { (success, error) in
            if success {
                print("Profile Picture Saved!")
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
        dismiss(animated: true, completion: nil)
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
