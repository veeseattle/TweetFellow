//
//  ViewController.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/5/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import UIKit
import Accounts
import Social


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
  lazy var refreshControl: UIRefreshControl! = UIRefreshControl()
  

  @IBOutlet weak var tableView: UITableView!
  
  var tweets = [Tweet]()
  var error : String?
  var networkController = NetworkController()
  var currentID : Int = 0
  var oldestID : Int = 0

  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CELL")
    
    self.tableView.estimatedRowHeight = 400
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.dataSource = self
    self.tableView.delegate = self

    retrieveTweets()

    
    //this implements pull to refresh
    self.refreshControl.attributedTitle = NSAttributedString(string: "fetching more tweets")
    self.refreshControl.addTarget(self, action: "refreshTweets:", forControlEvents: UIControlEvents.ValueChanged  )
    self.tableView.addSubview(refreshControl)
  }
  
  
  func retrieveTweets() {
    //this line populates the tweets array with data
    self.networkController.fetchTimeline(currentID, oldestID: oldestID) { (tweets, error) -> () in
      if error? == nil {
        self.tweets = tweets!
        self.tableView.reloadData()
        self.currentID = self.tweets.first!.id
        self.oldestID = self.tweets.last!.id
        //func tableView(tableView: UITableView, willDisplayCell cell: UITableView, forRow
        
        
      }
    }
  }
  

    
    // Do any additional setup after loading the view, typically from a nib.

  
  //tells the table how many cells to prepare
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
  
  //tells the table what to populate the cells with
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as TweetCell
    let tweet = self.tweets[indexPath.row]
    cell.userLabel.text = tweet.user
    cell.tweetLabel.text = tweet.text
    let imageURL = NSURL(string: tweet.imageURL)
    let imageData = NSData(contentsOfURL: imageURL!)
    cell.avatarImageView.image = UIImage(data: imageData!)
    return cell
    }
  


  func refreshTweets(sender: AnyObject) {
    retrieveTweets()
    self.tableView.reloadData()
    self.refreshControl.endRefreshing()
  }
    

  //instantiate the 2nd VC and pushes it to the stack
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let tweetDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("Tweet_Detail") as TweetDetailViewController
    tweetDetailVC.networkController = self.networkController
    //passes the tweet from this VC to the 2nd VC
    tweetDetailVC.tweet = self.tweets[indexPath.row]
    self.navigationController?.pushViewController(tweetDetailVC, animated: true)
    }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    if(indexPath.row == (self.tweets.count - 1)) {
      self.oldestID = indexPath.row
      
      self.networkController.fetchTimeline(self.oldestID, oldestID: self.oldestID) { (tweets, error) -> () in
        if error? == nil {
        }
      }
    }
  }



  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


