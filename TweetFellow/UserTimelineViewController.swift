//
//  UserTimelineViewController.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/8/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var networkController = NetworkController()
  var tweet : Tweet!
  var tweets : [Tweet]? = [Tweet]()
  

  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet var tableView: UITableView!
  @IBOutlet weak var tableViewHeader: UIView!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var bgImage: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CELL")
    
    
    self.networkController.fetchUserTimeline(tweet.user_id_str) { (userTweets, error) -> () in
      if error == nil {
        self.tweets = userTweets
        self.userLabel.text = self.tweet!.user
        self.tableView.reloadData()
  
        
        if self.tweet.profile_bg_url != nil {
          let bgURL = NSURL(string: self.tweet.profile_bg_url!)
          let bgData = NSData(contentsOfURL: bgURL!)
          self.bgImage.image = UIImage(data: bgData!)

        }
        if self.tweet.location != nil {
          self.locationLabel.text = self.tweet.location
        }
        else {
          self.locationLabel.text = "Chocolate Wonderland"
        }
        }
        
    }
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
  } //end of viewDidLoad

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.tweets!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as TweetCell
      let tweet = self.tweets![indexPath.row]
      self.tableView.estimatedRowHeight = 400
      self.tableView.rowHeight = UITableViewAutomaticDimension
      
      if tweet.retweetStatus != nil {
        var retweetDictionary = tweet.retweetStatus!["user"] as [String: AnyObject]?
        let retweetImage = retweetDictionary!["profile_image_url"] as String?
        let imageURL = NSURL(string: retweetImage!)
        let imageData = NSData(contentsOfURL: imageURL!)
        cell.avatarImageView.image = UIImage(data: imageData!)
      }
        
      else if tweet.retweetStatus == nil {
          if tweet.reply == nil {
          let imageURL = NSURL(string: tweet.imageURL)
          let imageData = NSData(contentsOfURL: imageURL!)
          cell.avatarImageView.image = UIImage(data: imageData!)
        }
      
        else {
            self.networkController.fetchTweetDetail(tweet.reply!.toInt()!) { (singleTweet, error) -> () in
            if error == nil {
            self.tweet.updateWithInfo(singleTweet)
            let imageURL = NSURL(string: self.tweet.imageURL)
            let imageData = NSData(contentsOfURL: imageURL!)
            cell.avatarImageView.image = UIImage(data: imageData!)
          }}}
      }
      cell.userLabel.text = tweet.user
      cell.tweetLabel.text = tweet.text
      
      return cell
    }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let tweetDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("Tweet_Detail") as TweetDetailViewController
    tweetDetailVC.networkController = self.networkController
    tweetDetailVC.tweet = self.tweets?[indexPath.row]
    self.navigationController?.pushViewController(tweetDetailVC, animated: true)
      }

        // Do any additional setup after loading the view
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
