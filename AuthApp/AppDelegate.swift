//
//  AppDelegate.swift
//  AuthApp
//
//  Created by Fernando Gonzalez on 10/4/21.
//

import UIKit

import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //acces keychain token
        
    
        
        let accessTokenn: String? = KeychainWrapper.standard.string(forKey: "accessToken")
    
    
        
        if accessTokenn != nil
                    
                
        {
        print("_________accessToken_________")
        print(accessTokenn!)
        print("_____________________________")
        // Take user to a home page
        //let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let homePage = mainStoryboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
          //  self.window?.rootViewController = homePage
                    
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            let viewController = storyBoard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
            
            print("_____________________________")
        
            
            
            }
        
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

