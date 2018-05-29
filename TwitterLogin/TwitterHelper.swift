//
//  TwitterHelper.swift
//  TwitterLogin
//
//  Created by Hafiz Muhammad Junaid on 16/05/2018.
//  Copyright © 2018 Hafiz Muhammad Junaid. All rights reserved.
//

import UIKit
import TwitterKit

final class TwitterUserModel: NSObject {
    
    private(set) var userID: String
    
    private(set) var name: String
    
    private(set) var screenName: String
    
    private(set) var isVerified: Bool
    
    private(set) var isProtected: Bool
    
    private(set) var profileImageURL: String
    
    private(set) var profileImageMiniURL: String
    
    private(set) var profileImageLargeURL: String
    
    private(set) var formattedScreenName: String
    
    private(set) var profileURL: URL
   
    
    init(user: TWTRUser) {
        
        self.userID = user.userID
        self.name = user.name
        self.screenName = user.screenName
        self.isVerified = user.isVerified
        self.isProtected = user.isProtected
        self.profileImageURL = user.profileImageURL
        self.profileImageMiniURL = user.profileImageMiniURL
        self.profileImageLargeURL = user.profileImageLargeURL
        self.formattedScreenName = user.formattedScreenName
        self.profileURL = user.profileURL
        
    }
    
}

class TwitterHelper: NSObject {
    
    fileprivate let twitterInstance = TWTRTwitter.sharedInstance()
    
    // MARK:- Configuration
    class func configureTwitter(consumerKey: String, consumerSecret: String) {
        
         TWTRTwitter.sharedInstance().start(withConsumerKey: consumerKey, consumerSecret: consumerSecret)
    }
    
   class func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
    func login(completion: @escaping (_ session:TWTRSession?, _ error:Error?)->()) {
        
        TWTRTwitter.sharedInstance().logIn(completion: { (session,error) in
            
            completion(session,error)
        
        })
    }
    
    func loadUser(userID: String,completion:@escaping (_ user: TWTRUser?, _ error: Error?)-> ()) {
        
        let client = TWTRAPIClient(userID: userID)
        client.loadUser(withID: userID, completion: { (user,error) in
          
            if error == nil {
                
                //let tUser = TwitterUserModel(user: user!)
                completion(user, nil)
            }
            
            else {
                completion(nil,error)
            }
        })
    }
    
    func requestEmail(userID: String, completion:@escaping (_ email:String?, _ error:Error?)->()) {
       
        let client = TWTRAPIClient(userID: userID)
        client.requestEmail(forCurrentUser: {(email, error) in
            completion(email,error)
            
        })
    }
    
    func logout(userID: String) {
        
        TWTRTwitter.sharedInstance().sessionStore.logOutUserID(userID)
    }
    
    
}
