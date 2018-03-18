//
//  CreateAccountViewController.swift
//  Alpha-Phi-Omega
//
//  Created by CheckoutUser on 3/7/18.
//  Copyright © 2018 Juan Ramirez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateAccountViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pledgeClassTextField: UITextField!
    @IBOutlet weak var graduationClassTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var accountCreatedLabel: UILabel!
    
    let pledgeClassPickerData = [String](arrayLiteral: "Spring", "Fall")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let thePicker = UIPickerView()
        pledgeClassTextField.inputView = thePicker
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pledgeClassPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pledgeClassPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pledgeClassTextField.text = pledgeClassPickerData[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            pledgeClassTextField.becomeFirstResponder()
        } else if textField == pledgeClassTextField {
            graduationClassTextField.becomeFirstResponder()
        } else if textField == graduationClassTextField {
            birthdayTextField.becomeFirstResponder()
        } else if textField == birthdayTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please fill in every field above", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully created an account.")
                    self.accountCreatedLabel.text = "You have successfully created an account. Head to login screen and input your credentials."
                    self.accountCreatedLabel.textColor = .white
                    // Goes to Setup page which lets user take a photo for their profile picture and choose username
                    
//                    let vc = self.storyboard?.instantiateInitialViewController()
//                    self.present(vc!, animated: true, completion: nil)
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
    }

}
