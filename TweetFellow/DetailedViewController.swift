//
//  DetailedViewController.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/7/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {
  
  var selectedTweet: [Tweet]?
  
  var detailTweetController : NetworkController?
  
  @IBOutlet weak var detailTableView: UITableView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.detailTableView.dataSource = self
    
    self.detailTweetController?.fetchTweetDetail(){(selectedTweets, errors) -> () in
      if errors? == nil {
        self.selectedTweet = selectedTweets!
        self.detailTableView.reloadData()
      }
    }
  }
  
  

  func tableView(detailTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.selectedTweet.count?
      }
  
  
  func tableView(detailTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as TweetCell
        let tweet = self.tweets[indexPath.row]
        
        cell.tweetLabel.text = tweet.text
        
        cell.userLabel.text = tweet.user
        let imageURL = NSURL(string: tweet.imageURL)
        let imageData = NSData(contentsOfURL: imageURL!)
        cell.avatarImageView.image = UIImage(data: imageData!)
        
        return cell
      }
      
      
    }
