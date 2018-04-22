//
//  DummyViewController.swift
//  XDLogin
//
//  Created by Team Swifters on 4/17/18.
//  Copyright © 2018 San Jose State University. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar

import Firebase
import FirebaseAuth


class DummyViewController: UIViewController {
    
    let appBar = MDCAppBar()
    
    @IBAction func logoutButton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeScreen")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red:0.40, green:0.23, blue:0.72, alpha:1.0)
        appBar.navigationBar.tintColor = UIColor.black
        appBar.addSubviewsToParent()
        
        title = "Material Components"
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
