//
//  TweetDetailViewController.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/7/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
  var networkController : NetworkController!
  var tweet : Tweet!
  
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
  
    @IBAction func showProfile(sender: AnyObject) {
      
      let userTimelineVC = self.storyboard?.instantiateViewControllerWithIdentifier("User_Timeline") as UserTimelineViewController
      userTimelineVC.networkController = self.networkController
      userTimelineVC.tweet = self.tweet
      self.navigationController?.pushViewController(userTimelineVC, animated: true)
      
      
      }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      //this fetches the single tweet detail
      self.networkController.fetchTweetDetail(tweet.id) { (singleTweet, error) -> () in
        
        if error == nil {
          self.tweet.updateWithInfo(singleTweet)
          self.userLabel.text = self.tweet.user
          self.textLabel.text = self.tweet.text
          var favorite : Int = self.tweet.favoriteCount!
          self.favoriteCountLabel.text = "Favorite Count: \(favorite)"
          let imageURL = NSURL(string: self.tweet.imageURL)
          let imageData = NSData(contentsOfURL: imageURL!)
          let buttonImage = UIImage(data: imageData!)
          self.profileButton.setImage(buttonImage, forState: .Normal)
          
        
          
      }
      
      
      }

      
        
  }

        // Do any additional setup after loading the view.
  
  
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
