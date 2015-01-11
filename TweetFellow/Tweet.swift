//
//  Tweet.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/5/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import Foundation

class Tweet {
  var id : Int
  var text : String
  var user : String
  var user_id : Int
  var user_id_str : String
  var imageURL : String
  var favoriteCount : Int?
  var location: String?
  var profile_bg_url : String?
  var reply : String?
  var retweetStatus : [String : AnyObject]?
  
  init ( _ jsonDictionary: [String : AnyObject]) {
    self.id = jsonDictionary["id"] as Int
    self.text = jsonDictionary["text"] as String
    let userDictionary = jsonDictionary["user"] as [String : AnyObject]
    self.user = userDictionary["name"] as String
    self.user_id = userDictionary["id"] as Int
    self.user_id_str = userDictionary["id_str"] as String
    self.imageURL = userDictionary["profile_image_url"] as String
    self.location = userDictionary["location"] as? String
    self.profile_bg_url = userDictionary["profile_image_url"] as? String
    self.reply = jsonDictionary["in_reply_to_status_id"] as? String
    self.retweetStatus = jsonDictionary["retweeted_status"] as? [String : AnyObject]
  }
  


  func updateWithInfo(infoDictionary : [String : AnyObject]) {
    self.favoriteCount = infoDictionary["favorite_count"] as? Int
}
  
  
}