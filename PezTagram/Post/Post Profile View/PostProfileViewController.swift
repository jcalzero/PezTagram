//
//  PostProfileViewController.swift
//  PezTagram
//
//  Created by Julien Calfayan on 3/6/19.
//  Copyright © 2019 Julien Calfayan. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class PostProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    var user: PFUser!
    var posts = [PFObject]()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var bioTextView: UITextView!
    @IBOutlet var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        usernameLabel.text = user.username
        
        bioTextView.text = user["bio"] as? String
        
        let imageFile = user["profilePicture"] as! PFFileObject
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
        query.whereKey("author", equalTo: user)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostProfileCollectionViewCell", for: indexPath) as! PostProfileCollectionViewCell
            
            let post = posts[indexPath.row]
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.postImageView.af_setImage(withURL: url)
            
            return cell
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
