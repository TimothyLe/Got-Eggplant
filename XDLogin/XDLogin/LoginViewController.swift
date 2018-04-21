//
//  LoginViewController.swift
//  XDLogin
//
//  Created by Team Swifters on 4/17/18.
//  Copyright © 2018 San Jose State University. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    //Cherie: Please fix segue
    @IBAction func BackToHome(_ sender: UIButton) {
        performSegue(withIdentifier: "homeScreen", sender: self)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if self.emailText.text == "" || self.passwordText.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailText.text!, password: self.passwordText.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "dummyScreen")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Placeholder for email
        emailText.text = "Email"
        emailText.textColor = UIColor.lightGray
        emailText.textAlignment = NSTextAlignment.center
        // Placeholder shows up whenever text field is empty, even when the keyboard shows up
        emailText.becomeFirstResponder()
        emailText.selectedTextRange = emailText.textRange(from: emailText.beginningOfDocument, to: emailText.beginningOfDocument)
        // Function handler for user entry
        func emailTextEditing(_ emailText: UITextView, shouldChangeTextIn range: NSRange, newText text: String) -> Bool {
            // Combine email text and new text to create updated string
            let currentText:String = emailText.text
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: text)
            // Updated text is empty, so add placeholder and set cursor to front of string
            if updateText.isEmpty {
                // Placeholder for email
                emailText.text = "Email"
                emailText.textColor = UIColor.lightGray
                emailText.textAlignment = NSTextAlignment.center
                // Endpoint of string
                emailText.selectedTextRange = emailText.textRange(from: emailText.beginningOfDocument, to: emailText.beginningOfDocument)
                // Done editing
                return false
            }
                // Placeholder text is showing and new string is > 0 then change text to black and prepare for user entry
            else if emailText.textColor == UIColor.lightGray && !text.isEmpty{
                emailText.text = nil
                emailText.textColor = UIColor.black
                emailText.textAlignment = NSTextAlignment.center
            }
            return true
        }
        
        // Placeholder for password
        passwordText.text = "Password"
        passwordText.textColor = UIColor.lightGray
        passwordText.textAlignment = NSTextAlignment.center
        // Placeholder shows up whenever text field is empty, even when the keyboard shows up
        passwordText.becomeFirstResponder()
        passwordText.selectedTextRange = passwordText.textRange(from: passwordText.beginningOfDocument, to: passwordText.beginningOfDocument)
        // Function handler for user entry
        func passwordTextEditing(_ passwordText: UITextView, shouldChangeTextIn range: NSRange, newText text: String) -> Bool {
            // Combine password text and new text to create updated string
            let currentText:String = passwordText.text
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: text)
            // Updated text is empty, so add placeholder and set cursor to front of string
            if updateText.isEmpty {
                // Placeholder for password
                passwordText.text = "Password"
                passwordText.textColor = UIColor.lightGray
                passwordText.textAlignment = NSTextAlignment.center
                // Endpoint of string
                passwordText.selectedTextRange = passwordText.textRange(from: passwordText.beginningOfDocument, to: passwordText.beginningOfDocument)
                // Done editing
                return false
            }
                // Placeholder text is showing and new string is > 0 then change text to black and prepare for user entry
            else if passwordText.textColor == UIColor.lightGray && !text.isEmpty{
                passwordText.text = nil
                passwordText.textColor = UIColor.black
                passwordText.textAlignment = NSTextAlignment.center
            }
            return true
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
