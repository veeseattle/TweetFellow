//
//  DetailViewController.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/7/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {
  
  var selectedTweet: [Tweet]?
  @IBOutlet weak var tweetText: UITextField!
  @IBOutlet weak var tweetUser: UITextField!
  @IBOutlet weak var tweetImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
}

  override func override func didReceiveMemoryWarning() {
    <#code#>
  }
  
}
