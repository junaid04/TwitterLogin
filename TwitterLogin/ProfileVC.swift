//
//  ProfileVC.swift
//  TwitterLogin
//
//  Created by Hafiz Muhammad Junaid on 22/05/2018.
//  Copyright © 2018 Hafiz Muhammad Junaid. All rights reserved.
//

import UIKit
import TwitterKit

class ProfileVC: UIViewController {

    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblProfileURL: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var userData:TWTRUser? = nil
    var email:String? = nil
    let twitterHelper = TwitterHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let user = userData {
            lblUsername.text = "Username: " + user.name
            lblFullName.text = "Full Name: " +  user.screenName
            lblProfileURL.text = "ProfileURL: " + user.profileURL.absoluteString
            
            let emailText = email ?? "Not Found"
            lblEmail.text = "Email: " + emailText
            
            self.activityIndicator.startAnimating()
            DispatchQueue.global().async {
               
                if let imgURL = URL(string: user.profileImageURL) {
                    if let imgData = try? Data(contentsOf: imgURL) {
                        let image = UIImage(data: imgData)
                       
                        DispatchQueue.main.async(execute: {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            self.imgViewUser.image = image
                        })
                        
                    }
                }
            }
           
        }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button Action
    @IBAction func actionLogout(_ sender: Any) {
        
        self.twitterHelper.logout(userID: userData!.userID)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
