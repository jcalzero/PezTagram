//
//  PostViewController.swift
//  PezTagram
//
//  Created by Julien Calfayan on 3/2/19.
//  Copyright © 2019 Julien Calfayan. All rights reserved.
//

import UIKit
import Parse
import MessageInputBar

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {

    @IBOutlet var postTableView: UITableView!
    @IBOutlet var usernameLabelButton: UIButton!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var profilePictureView: UIImageView!
    
    var post: PFObject!
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Add a Comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        let user = post["author"] as! PFUser
        usernameLabelButton.setTitle(user.username, for: .normal)
 
        captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        photoView.af_setImage(withURL: url)
        
        let imageFileTwo = user["profilePicture"] as! PFFileObject
        let urlStringTwo = imageFileTwo.url!
        let urlTwo = URL(string: urlStringTwo)!
        
        profilePictureView.layer.cornerRadius = 25
        profilePictureView.clipsToBounds = true
        profilePictureView.af_setImage(withURL: urlTwo)
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = post
        comment["author"] = PFUser.current()!
        
        post.add(comment, forKey: "comments")
        
        post.saveInBackground { (success, error) in
            if success {
                print("Comment Saved")
            } else {
                print("Error Saving Comment")
            }
        }
        
        postTableView.reloadData()
        
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    @IBAction func addACommentButton(_ sender: Any) {
        showsCommentBar = true
        becomeFirstResponder()
        
        commentBar.inputTextView.becomeFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let comments = (post["comments"] as? [PFObject]) ?? []
        return comments.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comments = (post["comments"] as? [PFObject]) ?? []
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        
        let comment = comments[indexPath.row + 1]
        cell.commentTextView.text = comment["text"] as? String
        
        let user = comment["author"] as! PFUser
        cell.usernameCommentLabel.text = user.username

        let imageFile = user["profilePicture"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.profilePicture.layer.cornerRadius = 20
        cell.profilePicture.clipsToBounds = true
        cell.profilePicture.af_setImage(withURL: url)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let postProfileViewController = segue.destination as! PostProfileViewController
        let user = post["author"] as! PFUser
        postProfileViewController.user = user
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
