//
//  CommentTableViewCell.swift
//  PezTagram
//
//  Created by Julien Calfayan on 3/6/19.
//  Copyright © 2019 Julien Calfayan. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet var usernameCommentLabel: UILabel!
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var commentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
