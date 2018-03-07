//
//  ViewController.swift
//  Alpha-Phi-Omega
//
//  Created by Local Account 436-24 on 2/26/18.
//  Copyright © 2018 Juan Ramirez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hides keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Hides keyboard when user taps 'Return' key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            // Alert to tell the user that there was an error because they didn't fill anything in the textfields
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    // Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    // Go to the HomeViewController if the login is successful
                    let vc = self.storyboard?.instantiateInitialViewController()
                    self.present(vc!, animated: true, completion: nil)
                }
                else {
                    // Tells the user that there is an error and then gets Firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        
    }
    
}

