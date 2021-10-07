//
//  SignUpViewController.swift
//  AuthApp
//
//  Created by Fernando Gonzalez on 10/4/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var user_nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        print("Back Button Tapped")
        
        //canceling and gping back
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("Sign Up Button Tapped")
        
        
        // Validating text fields
        if (user_nameTextField.text?.isEmpty)! ||
            (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)!
        {
            //Dispay alert message here from function
            displayMessage(userMessage: "All fields are required.")
            return
        }
        
        //Validatre passwords
        if ((passwordTextField.text?.elementsEqual(passwordTextField.text!))! != true)
        {
            //Dispay alert message here from function
            displayMessage(userMessage: "Passwords need to match.")
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
        let myUrl = URL(string: "http://127.0.0.1:8000/api/users/")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        //
        let postString = [
            "user_name": user_nameTextField.text!,
            "email": emailTextField.text!,
            "password": passwordTextField.text!,
        ] as [String: String]
        
        //converting
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again.")
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            //
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            //if any errors
            if error != nil {
                self.displayMessage(userMessage: "Could not successfully reqest. Please Try again later")
                print("error=\(String(describing:error))")
            }
            
            
            //convert response sent from server to a Dictionary
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as?NSDictionary
                //
                if let parseJSON = json {
                    //
                    let userId = parseJSON["email"] as? String
                    print("User id: \(String(describing: userId!))")
                    
                    
                    if (userId?.isEmpty)!
                    {
                        //
                        self.displayMessage(userMessage: "Could not successfully perform this resquest. Please try again later")
                        return
                    }else{
                        self.displayMessage(userMessage: "Successfully Registered a New Account. Please proceed to Sign in ")
                    }
 
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
        
        //end class
    }
    
    
    //
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    
    // function message
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            //
            let OKAction = UIAlertAction(title: "OK", style: .default)
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
    

    
    
    //end
}
