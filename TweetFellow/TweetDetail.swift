//
//  TweetDetail.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/7/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import Foundation

class TweetDetail {
  var id : Int
  var text : String
  var user : String
  var imageURL : String
  var favouriteCount : Int
  
  init ( _ jsonDictionary: [String : AnyObject]) {
    self.id = jsonDictionary["id"] as Int
    self.text = jsonDictionary["text"] as String
    let userDictionary = jsonDictionary["user"] as [String : AnyObject]
    self.user = userDictionary["name"] as String
    self.imageURL = userDictionary["profile_image_url"] as String
    self.favouriteCount = jsonDictionary["favourite_count"] as Int
  }
  
  
}

  