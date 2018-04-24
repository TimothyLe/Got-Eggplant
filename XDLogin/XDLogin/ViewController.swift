//
//  ViewController.swift
//
//  Created by Team Swifters on 4/16/18.
//  Copyright © 2018 San Jose State University. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Login Button
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "HomeToLoginSegue", sender: self)
    }
    
    //Sign up Button
    @IBAction func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "HomeToSignupSegue", sender: self)
    }
    
}
