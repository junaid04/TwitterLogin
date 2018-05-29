//
//  ViewController.swift
//  TwitterLogin
//
//  Created by Hafiz Muhammad Junaid on 09/05/2018.
//  Copyright © 2018 Hafiz Muhammad Junaid. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {
    
    let twitterHelper = TwitterHelper()
    var userData:TWTRUser? = nil
    var userEmail: String? = nil

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.activityIndicator.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Method
    fileprivate func showAlert(title:String,message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Twitter Function
    fileprivate func callLogin() {
        
        twitterHelper.login(completion: { (session,error) in
            
            if error == nil {
                
                self.callLoadUser(userID: session!.userID)
            }
            else {
                self.showAlert(title: "Error", message: error!.localizedDescription)
            }
            
        })
    }
    
    fileprivate func callLoadUser(userID: String) {
        
        twitterHelper.loadUser(userID: userID, completion: { (user,error) in
            
            if error == nil {
                self.userData = user
                self.callRequestEmail(userID: user!.userID)
            }
            else {
                self.showAlert(title: "Error", message: error!.localizedDescription)
            }
        })
        
    }
    
    fileprivate func callRequestEmail(userID: String) {
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        twitterHelper.requestEmail(userID: userID, completion: { (email,error) in
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            
            if error == nil {
                
                self.userEmail = email
                self.performSegue(withIdentifier: "segueProfile", sender: nil)
                
            }
            else {
                self.showAlert(title: "Error", message: error!.localizedDescription)
            }
        })
        
    }

    // MARK: - Button Action
    @IBAction func actionLogin(_ sender: Any) {
        
        self.callLogin()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let profileVC = segue.destination as? ProfileVC {
            
            profileVC.userData = self.userData
            profileVC.email = self.userEmail
        }
    }
    
}

