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
import FirebaseDatabase

class CreateAccountViewController: UIViewController, UITextFieldDelegate/*, UIPickerViewDelegate, UIPickerViewDataSource*/ {
    
    var brothersRef : DatabaseReference!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pledgeClassTextField: UITextField!
    @IBOutlet weak var membershipStatusTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var familyTextField: UITextField!
    @IBOutlet weak var bigBrotherTextField: UITextField!
    @IBOutlet weak var littleBrotherTextField: UITextField!
    
    @IBOutlet weak var accountCreatedLabel: UILabel!
    
//    let pledgeClassPickerData = [String](arrayLiteral: "Spring", "Fall")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brothersRef = Database.database().reference().child("brothers")

//        let thePicker = UIPickerView()
//        pledgeClassTextField.inputView = thePicker
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func addBrother() {
        let key = brothersRef.childByAutoId().key
        
        let brother = ["id" : key,
                       "firstName" : firstNameTextField.text! as String,
                       "lastName" : lastNameTextField.text! as String,
                       "pledgeClass" : pledgeClassTextField.text! as String,
                       "membershipStatus" : membershipStatusTextField.text! as String,
                       "birthday" : birthdayTextField.text! as String,
                       "family" : familyTextField.text! as String,
                       "big" : bigBrotherTextField.text! as String,
                       "little" : littleBrotherTextField.text! as String]
        
        brothersRef.child(key).setValue(brother)
    }
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pledgeClassPickerData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pledgeClassPickerData[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        pledgeClassTextField.text = pledgeClassPickerData[row]
//    }
    
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
            membershipStatusTextField.becomeFirstResponder()
        } else if textField == membershipStatusTextField {
            birthdayTextField.becomeFirstResponder()
        } else if textField == birthdayTextField {
            familyTextField.becomeFirstResponder()
        } else if textField == familyTextField {
            bigBrotherTextField.becomeFirstResponder()
        } else if textField == bigBrotherTextField {
            littleBrotherTextField.becomeFirstResponder()
        } else if textField == littleBrotherTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        if firstNameTextField.text == "" || lastNameTextField.text == "" || passwordTextField.text == "" || /*pledgeClassTextField.text == "" ||*/ membershipStatusTextField.text == ""  || birthdayTextField.text == "" || familyTextField.text == "" || bigBrotherTextField.text == "" || littleBrotherTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please fill in every field above", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else {
            addBrother()
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
