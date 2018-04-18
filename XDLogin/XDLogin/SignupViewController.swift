//
//  SignupViewController.swift
//  XDLogin
//
//  Created by student on 4/17/18.
//  Copyright © 2018 San Jose State University. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func Signup(_ sender: Any) {
        if emailText.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "dummyScreen")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
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
        // Placeholder for username
        usernameText.text = "Username"
        usernameText.textColor = UIColor.lightGray
        usernameText.textAlignment = NSTextAlignment.center
        // Placeholder shows up whenever text field is empty, even when the keyboard shows up
        usernameText.becomeFirstResponder()
        usernameText.selectedTextRange = usernameText.textRange(from: usernameText.beginningOfDocument, to: usernameText.beginningOfDocument)
        // Function handler for user entry
        func usernameTextEditing(_ usernameText: UITextView, shouldChangeTextIn range: NSRange, newText text: String) -> Bool {
            // Combine username text and new text to create updated string
            let currentText:String = usernameText.text
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: text)
            // Updated text is empty, so add placeholder and set cursor to front of string
            if updateText.isEmpty {
                // Placeholder for username
                usernameText.text = "Username"
                usernameText.textColor = UIColor.lightGray
                usernameText.textAlignment = NSTextAlignment.center
                // Endpoint of string
                usernameText.selectedTextRange = usernameText.textRange(from: usernameText.beginningOfDocument, to: usernameText.beginningOfDocument)
                // Done editing
                return false
            }
                // Placeholder text is showing and new string is > 0 then change text to black and prepare for user entry
            else if usernameText.textColor == UIColor.lightGray && !text.isEmpty{
                usernameText.text = nil
                usernameText.textColor = UIColor.black
                usernameText.textAlignment = NSTextAlignment.center
            }
            return true
        }

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
