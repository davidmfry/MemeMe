//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by David on 3/12/15.
//  Copyright (c) 2015 David Fry. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell
{
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
