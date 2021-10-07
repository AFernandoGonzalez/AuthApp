//
//  FeedViewController.swift
//  AuthApp
//
//  Created by Fernando Gonzalez on 10/4/21.
//

import UIKit
import SwiftKeychainWrapper

class FeedViewController: UIViewController {
    
    @IBOutlet weak var userFullNameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signoutButtonTapped(_ sender: Any) {
        print("Signout Button Tapped")
        
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        
        let homepage = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = homepage

    }
    
    @IBAction func viewProfileTapped(_ sender: Any) {
        print("View Profile Button Tapped")
    }
    
}
