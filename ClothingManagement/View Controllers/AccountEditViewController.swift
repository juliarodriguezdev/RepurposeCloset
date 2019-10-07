//
//  AccountEditViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 10/1/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class AccountEditViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var nameTextField: ClosetTextField!
    
    @IBOutlet weak var closetTextField: ClosetTextField!
    
    @IBOutlet weak var editAccountLabel: UILabel!
    
    @IBOutlet weak var updateButton: ClosetButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        closetTextField.delegate = self
        guard let user = user else { return }
        checkGenderForColorUI(user: user)
        editAccountLabel.text = "Select your name, closet Name below to edit... \n\nName: \(user.name!) \nCloset name: \(user.closetName!)"
        nameTextField.placeholder = "Enter new account name..."
        closetTextField.placeholder = "Enter new closet name..."
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        closetTextField.resignFirstResponder()
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        guard let user = user else { return }
        
        if let editedName = nameTextField.text, let editedClosetName = closetTextField.text {
            if editedName.isEmpty && editedClosetName.isEmpty {
                DispatchQueue.main.async {
                    self.presentAlert(title: "Empty text fields", message: "Please enter an edit to save changes.")
                }
                return
            }
            
            if editedName != "", editedName != user.name {
                user.name = editedName
                nameTextField.text = editedName
            }
            
            if editedClosetName != "", editedClosetName != user.closetName {
                user.closetName = editedClosetName
                closetTextField.text = editedClosetName
            }
            UserController.shared.updateUserInfo(user: user) { (success) in
                if success {
                    // show alert pop up
                    DispatchQueue.main.async {
                        self.presentAlert(title: "Account updated", message: "changes successfully saved")
                        self.editAccountLabel.text = "Select your name, Closet Name to Edit... \n\nName: \(user.name!) \nCloset Name: \(user.closetName!)"
                        self.nameTextField.text = ""
                       self.closetTextField.text = ""
                    }
                } else {
                    // show alert pop up
                    DispatchQueue.main.async {
                        self.presentAlert(title: "Account Error", message: "changes did not save")
                    }
                }
                
            }
            nameTextField.resignFirstResponder()
            closetTextField.resignFirstResponder()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
              if self.view.frame.origin.y == 0 {
                  // 1/4th of view
                  self.view.frame.origin.y -= keyboardSize.height/4
                      //keyboardSize.height
              }
          }
      }

      @objc func keyboardWillHide(notification: NSNotification) {
          if self.view.frame.origin.y != 0 {
              self.view.frame.origin.y = 0
          }
      }
    
    
    @IBAction func deleteAccountTapped(_ sender: UIButton) {
        guard let user = user else { return }
        deleteUserAccount(user: user)
    }
    
    func checkGenderForColorUI(user: User?) {
        if user?.isMale == true {
            self.view.backgroundColor = UIColor.malePrimary
        } else if user?.isMale == false {
            self.view.backgroundColor = UIColor.femalePrimary
        } else {
            self.view.backgroundColor = UIColor.neutralPrimary

        }
    }
    
    func deleteUserAccount(user: User) {
        
        let alertController = UIAlertController(title: "Delete Account", message: "This will delete all of your closet inventory and donated/recycled contributions. \nAre you sure you want to delete your account?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Delete Account", style: .destructive) { (_) in
            UserController.shared.deleteUser(user: user) { (success) in
                if success {
                    self.presentAlert(title: "Account deleted successfully", message: "Please restart the app to browse, \nor create a new account")
                } else {
                    self.presentAlert(title: "Error", message: "Account was not deleted")
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func presentAlert(title: String, message: String) {
         
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
         let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
         
         alertController.addAction(okayAction)
         self.present(alertController, animated: true)
     }
}


extension AccountEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocapitalizationType = .words
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
