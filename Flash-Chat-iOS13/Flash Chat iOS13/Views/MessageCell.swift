//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Saurabh Kumar Verma on 17/07/2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView?
    @IBOutlet weak var label: UILabel?
    @IBOutlet weak var rightImageView: UIImageView?
    @IBOutlet weak var leftImageView: UIImageView?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        messageBubble?.layer.cornerRadius = (messageBubble?.frame.size.height ?? 0) / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
