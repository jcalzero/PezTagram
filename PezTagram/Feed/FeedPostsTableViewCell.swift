//
//  FeedPostsTableViewCell.swift
//  PezTagram
//
//  Created by Julien Calfayan on 3/2/19.
//  Copyright © 2019 Julien Calfayan. All rights reserved.
//

import UIKit

class FeedPostsTableViewCell: UITableViewCell {

    @IBOutlet var profilePictureView: UIImageView!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var usernameLabelTwo: UILabel!
    @IBOutlet var usernameLabelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
