//
//  ProfileViewController.swift
//  Alpha-Phi-Omega
//
//  Created by CheckoutUser on 3/7/18.
//  Copyright © 2018 Juan Ramirez. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser?.uid == nil {
            logout()
        }
        
        setupProfile()
    }
    
    @IBAction func uploadImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        saveChanges()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        logout()
    }
    
    func setupProfile() {
//        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
//        profileImage.clipsToBounds = true
            
        let uid = Auth.auth().currentUser?.uid
        databaseRef.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String : AnyObject] {
                self.username.text = dict["username"] as? String
                if let profileImageURL = dict["pic"] as? String {
                    let url = URL(string: profileImageURL)
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        DispatchQueue.main.async {
                            self.profileImage?.image = UIImage(data: data!)
                        }
                    }).resume()
                }
            }
        })
    }
    
    func logout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login")
        present(loginViewController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveChanges() {
        let imageName = NSUUID().uuidString
        
        let storedImage = storageRef.child("profileImages").child(imageName)
        
        if let uploadData = UIImagePNGRepresentation(self.profileImage.image!) {
            storedImage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                storedImage.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    if let urlText = url?.absoluteString {
                        self.databaseRef.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["pic" : urlText], withCompletionBlock: { (error, ref) in
                            if error != nil {
                                print(error!)
                                return
                            }
                        })
                    }
                })
            })
        }
        
        
    }

}
