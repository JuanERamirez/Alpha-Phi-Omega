//
//  EventsViewController.swift
//  Alpha-Phi-Omega
//
//  Created by CheckoutUser on 3/7/18.
//  Copyright © 2018 Juan Ramirez. All rights reserved.
//

import UIKit
import Firebase
import os.log

class EventsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var eventNameTF: UITextField!
    @IBOutlet weak var eventDateTF: UITextField!
    @IBOutlet weak var eventLocationTF: UITextField!
    @IBOutlet weak var eventTimeTF: UITextField!
    @IBOutlet weak var eventSummaryTF: UITextField!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    var event : Event?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegates()
        
        updateSaveButtonState()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == eventNameTF {
            eventDateTF.becomeFirstResponder()
        } else if textField == eventDateTF {
            eventLocationTF.becomeFirstResponder()
        } else if textField == eventLocationTF {
            eventTimeTF.becomeFirstResponder()
        } else if textField == eventTimeTF {
            eventSummaryTF.becomeFirstResponder()
        } else if textField == eventSummaryTF {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        eventSummaryTF.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided with the following: \(info)")
        }
        
        eventImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling.", log: OSLog.default, type: .debug)
            return
        }
        
        let name = eventNameTF.text ?? ""
        let date = eventDateTF.text ?? ""
        let location = eventLocationTF.text ?? ""
        let time = eventTimeTF.text ?? ""
        let summary = eventSummaryTF.text ?? ""
        
        event = Event(name: name, date: date, time: time, location: location, summary: summary, photo: eventImage.image)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupDelegates() {
        eventNameTF.delegate = self
        eventDateTF.delegate = self
        eventLocationTF.delegate = self
        eventTimeTF.delegate = self
        eventSummaryTF.delegate = self
    }
    
    private func updateSaveButtonState() {
        let text = eventNameTF.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}
