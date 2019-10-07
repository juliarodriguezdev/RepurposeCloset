//
//  UpdateQuantityViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/9/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class UpdateQuantityViewController: UIViewController {

    var category: Category?
    var user: User?
    var editableQuantity: Int = 0
    
    @IBOutlet weak var quantityTextField: ClosetTextField!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var subtractButton: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.addDoneButtonOnKeyboard()
        guard let category = category,
            let user = user else { return }
        editableQuantity = category.quantity
        checkGenderForUIColor(user: user)
        //quantityTextField.text = "\(category.quantity)"
        categoryNameLabel.text = "\(category.name) Category \ncontains: \(editableQuantity)"
        

        // Do any additional setup after loading the view.
    }
    func checkGenderForUIColor(user: User) {
        
        switch user.isMale {
        case true:
            //quantityTextField.backgroundColor = UIColor.malePrimary
            addButton.backgroundColor = UIColor.malePrimary
            addButton.tintColor = UIColor.maleAccent
            subtractButton.backgroundColor = UIColor.malePrimary
            subtractButton.tintColor = UIColor.maleAccent
            self.view.backgroundColor = UIColor.malePrimary
        case false:
            //quantityTextField.backgroundColor = UIColor.femalePrimary
            addButton.backgroundColor = UIColor.femalePrimary
            addButton.tintColor = UIColor.femaleAccent
            subtractButton.backgroundColor = UIColor.femalePrimary
            subtractButton.tintColor = UIColor.femaleAccent
            self.view.backgroundColor = UIColor.femalePrimary
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let category = category else { return }
        let changedValue = editableQuantity
        
        if changedValue >= 0 {
            category.quantity = changedValue
            CategoryController.shared.updateCategory(category: category) { (success) in
                if success {
                    // TODO: Add Saving Wheel Indicator
                    print("Quantity in category saved successfully")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        //self.dismiss(animated: true)
                    }
                }
            }
            
        } else if changedValue <= 0 {
            
            DispatchQueue.main.async {
                // alert action to show it is zero
                let alertController = UIAlertController(title: "Cannot Update!", message: "Quantity entered is less than zero, \nre-enter a # greater than or equal to zero", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            return
        }
       
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let category = category else { return }
        editableQuantity += 1
        categoryNameLabel.text = "\(category.name) Category \ncontains: \(editableQuantity)"
       // quantityTextField.text = String(quantity)

    }
    @IBAction func subtractButtonTapped(_ sender: Any) {
        if editableQuantity == 0 {
            // helper func
            presentUIHelperAlert(title: "Invalid Entry", message: "This category contains 0 items, \ncannot subtract any further")
            return
        } else {
            guard let category = category else { return }
            editableQuantity -= 1
            categoryNameLabel.text = "\(category.name) Category \ncontains: \(editableQuantity)"
        }
        
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        presentUIHelperAlert(title: "Information", message: "Select + : to increment \nSelect - : to decrement \nEnter #... : prompts number pad")
    }
    
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        captureTextFieldInput()
        quantityTextField.resignFirstResponder()
    }
    
    func addDoneButtonOnKeyboard(){
         let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
         doneToolbar.barStyle = .default

         let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
         let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
         done.tintColor = .black

         let items = [flexSpace, done]
         doneToolbar.items = items
         doneToolbar.sizeToFit()
      
      quantityTextField.inputAccessoryView = doneToolbar
     }

     @objc func doneButtonAction() {
        captureTextFieldInput()
      quantityTextField.resignFirstResponder()
     }
    
    func captureTextFieldInput() {
        guard let category = category else { return }
               if let newQuantity = quantityTextField.text, newQuantity != "" {
                   if let textFieldToInt = Int(newQuantity) {
                       self.editableQuantity = textFieldToInt
                       self.categoryNameLabel.text = "\(category.name) Category \ncontains: \(self.editableQuantity)"
                   }
               }
    }
    
    func presentUIHelperAlert(title: String, message: String) {
           
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
           
           alertController.addAction(okayAction)
           self.present(alertController, animated: true)
       }
}
extension UpdateQuantityViewController: UITextFieldDelegate {
    
}
