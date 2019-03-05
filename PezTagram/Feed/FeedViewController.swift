//
//  FeedViewController.swift
//  PezTagram
//
//  Created by Julien Calfayan on 3/1/19.
//  Copyright © 2019 Julien Calfayan. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        var currentUser = PFUser.current()
        self.dismiss(animated: true, completion: nil)
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
