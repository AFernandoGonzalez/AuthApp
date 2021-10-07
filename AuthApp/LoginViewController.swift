//
//  LoginViewController.swift
//  AuthApp
//
//  Created by Fernando Gonzalez on 10/4/21.
//

import UIKit
import Alamofire

//
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
     
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //
        
        
        
        
        //
    }
    
    
//    login, register button

    @IBAction func onSignIn(_ sender: Any) {
        print("Sign in Button Tapped")
        
        //
        let email = usernameField.text
        let password = passwordField.text
        
        // cheack if required fields are not empty
        if (email?.isEmpty)! || (password?.isEmpty)!
        {
            //Display alert message
            print("Email \(String(describing: email)) or passwod \(String(describing: password)) is empty")
            
            displayMessage(userMessage: "One of the required fields is missing!")
            
            return
        }
        
        
        //Create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        myActivityIndicator.center = view.center
        
        //
        myActivityIndicator.hidesWhenStopped = false
        
        //start activity Indicator
        myActivityIndicator.startAnimating()
        
        //
        view.addSubview(myActivityIndicator)
        
        
        //
        let myUrl = URL(string: "http://127.0.0.1:8000/api/login/")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        //
        let postString = [
            "email": email!,
            "password": password!,
        ] as [String: String]
        
        
        //converting
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again.")
        }
        
        
        //
        
        let task = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
        //
        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
        //
            //if any errors
        if error != nil {
            self.displayMessage(userMessage: "Could not successfully reqest. Please Try again later")
                print("error=\(String(describing:error))")
                return
            }
            
            
            //convert response sent from server to a Dictionary
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as?NSDictionary
                //
                if let parseJSON = json {
                    //
                    let accessToken = parseJSON["token"] as? String
                    print("Access Token: \(String(describing: accessToken!))")
                    
                    //you can store user id if you have one
                    //keychain
                    
                    let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                    
                    print("accessToken")
                    
                    //iosUser4@gmail.com
   
                    print("The Access token result: \(saveAccessToken)")
                    
                    
                    if (accessToken?.isEmpty)!
                    {
                        //
                        self.displayMessage(userMessage: "Could not successfully perform this resquest. Please try again later")
                        return
                    }
                    
                    //if everything is ok we take the user to the authenticated page
                    //print("Im in the feed 1")
                    DispatchQueue.main.async {
//                        let homepage = self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
//                        let appDelegate = UIApplication.shared.delegate
//                        appDelegate?.window??.rootViewController = homepage
                      
                    
                    //if everything is ok we take the user to the authenticated page
                    let loginBtnViewController =
                    self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
                    
                    self.present(loginBtnViewController, animated: true)
                        
                        
                        //print("Im in the feed 2")
                    }
                    //print("Im in the feed 3")
                                
                    
                    
                    //
            }else {
                    //
                    self.displayMessage(userMessage: "Could not successfully perform this resquest. Please try again later")
                }
                
                
            ///end
            } catch {
                //
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                //
                self.displayMessage(userMessage: "Could not successfully perform this resquest. Please try again later")
                print(error)
            }
            
            
            
        }
        task.resume()
        
        
        
    //end of func
    }
    
    
    
    @IBAction func onSignUp(_ sender: Any) {
        print("Sign Up Button Tapped")
        
        //
        let registerViewController =
        self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.present(registerViewController, animated: true)
        //end Class
    }
    
    
    // function message
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            //
            let OKAction = UIAlertAction(title: "ok", style: .default)
            {
                (action:UIAlertAction!) in
                //
                print("Ok button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            //
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
        
    
    //
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    
    


//end
}
