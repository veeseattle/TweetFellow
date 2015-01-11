//
//  NetworkController.swift
//  TweetFellow
//
//  Created by Vania Kurniawati on 1/7/15.
//  Copyright (c) 2015 Vania Kurniawati. All rights reserved.
//

import Foundation

import Accounts

import Social

class NetworkController {
  
  var twitterAccount : ACAccount?
  
  init() {
    //I'm a blank init
  }
  

  //this fetches the timeline data for the first VC
  func fetchTimeline (currentID : Int, oldestID: Int, completionHandler : ([Tweet]?, String?) -> ()) {
        //this establishes the Twitter account connection
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {(granted: Bool, error: NSError!) -> Void in
              if granted {
                let twitterAccounts = accountStore.accountsWithAccountType(accountType)
                //check to make sure account is not empty
                if !twitterAccounts.isEmpty {
                  //take first twitter account
                  self.twitterAccount = twitterAccounts.first as? ACAccount
                  let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
                  let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: ["since_id": currentID, "max_id": oldestID ])
                  twitterRequest.account = self.twitterAccount
                  //get the actual data
                  twitterRequest.performRequestWithHandler(){(data, response, error) -> Void in
                      switch response.statusCode {
                        case 200...299:
                          println("Everything is a-OK")
                          //serialize the data
                          if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
                            var tweetsLocal = [Tweet]()
                            // loop back for every object in jsonArray
                            for object in jsonArray {
                              if let jsonDictionary = object as? [String: AnyObject] {
                                let tweet = Tweet(jsonDictionary)
                                tweetsLocal.append(tweet)
                              }
                            }
                              //brings this back to the main queue and passes the data through the closure exp
                              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                completionHandler(tweetsLocal, nil)
                                })
                              
                          
                        }
                        case 400...499 :
                          println("Something is broken")
                        case 500...599 :
                          println("Something might have happened on the server-side, try again")
                        default :
                          println("Status code is unknown")
                      
}
                    

                  
                  }
                }
          }
    }
  }
  //this fetches data for the second VC
  func fetchTweetDetail ( id: Int, completionHandler2: ([String: AnyObject], String?) -> ()) {

          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/show.json?id=\(id)")
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          twitterRequest.account = self.twitterAccount
          twitterRequest.performRequestWithHandler(){(data, response, error) -> Void in
            switch response.statusCode {
            case 200...299:
              println("Everything is a-OK")
              var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String: AnyObject]
              
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionHandler2(jsonDictionary!, nil)
                })

            case 400...499 :
              println("Something is broken")
            case 500...599 :
              println("Something might have happened on the server-side, try again")
            default :
              println("Status code is unknown")
              
            }
            
            
            
          }
  }
  
  //this fetches data for the third VC
  func fetchUserTimeline (userID: String, completionHandler : ([Tweet]?, String?) -> ()) {
      println("\(userID)")
      let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=\(userID)")
   
      let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
      twitterRequest.account = self.twitterAccount
      twitterRequest.performRequestWithHandler(){(data, response, error) -> Void in
        switch response.statusCode {
         case 200...299:
            println("Everything is a-OK")
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
                var tweetsLocal = [Tweet]()
                // loop back for every object in jsonArray
                for object in jsonArray {
                  if let jsonDictionary = object as? [String: AnyObject] {
                    let tweet = Tweet(jsonDictionary)
                    tweetsLocal.append(tweet)
                  }
              }
            
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(tweetsLocal, nil)
                })
              
              
              }
            case 400...499 :
              println("Something is broken")
            case 500...599 :
              println("Something might have happened on the server-side, try again")
            default :
              println("Status code is unknown")
              
            }
            
        }
        
          }
//  
//  func fetchReplyTo (userName: String, completionHandler: [Tweet]?, String?) -> () {
//    let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/show.json?id=\(id)")
//    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
//    twitterRequest.account = self.twitterAccount
//    twitterRequest.performRequestWithHandler(){(data, response, error) -> Void in
//      switch response.statusCode {
//      case 200...299:
//        println("Everything is a-OK")
//        var jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String: AnyObject]
//        
//        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//          completionHandler2(jsonDictionary!, nil)
//        })
//        
//      case 400...499 :
//        println("Something is broken")
//      case 500...599 :
//        println("Something might have happened on the server-side, try again")
//      default :
//        println("Status code is unknown")
//        
//  }
      }



      