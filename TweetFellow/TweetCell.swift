//
//  TweetCell.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/5/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
  
  

@IBOutlet weak var tweetLabel: UILabel!
@IBOutlet weak var userLabel: UILabel!
@IBOutlet weak var avatarImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    //Configure the view for the selected state
  }

  }


