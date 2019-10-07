//
//  DisposeClothesTableViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/21/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class DisposeClothesTableViewCell: UITableViewCell {
    
    var category: Category?
// updating the categories
    var disposedNumber: Int?
    
    @IBOutlet weak var categoryLabel: ClosetLabel!
    
    @IBOutlet weak var quantityLabel: ClosetLabel!
    @IBOutlet weak var disposeQuantityTextField: ClosetTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disposeQuantityTextField.delegate = self
        self.addDoneButtonOnKeyboard()
    }
    
    func updateViews() {
        guard let category = category  else { return }
        categoryLabel.text = category.name
        quantityLabel.text = "Contains: \(category.quantity) items"
        
        }
    
   
   func addDoneButtonOnKeyboard(){
       let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
       doneToolbar.barStyle = .default

       let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
       done.tintColor = .darkGray
       let items = [flexSpace, done]
       doneToolbar.items = items
       doneToolbar.sizeToFit()
    
    disposeQuantityTextField.inputAccessoryView = doneToolbar
   }

   @objc func doneButtonAction() {
    disposeQuantityTextField.resignFirstResponder()
   }
   
}
extension DisposeClothesTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.keyboardType = .numberPad
        textField.adjustsFontForContentSizeCategory = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }
}
extension DisposeClothesTableViewCell: DisposeClothesViewControllerDelegate {
    
    func confirmDisposeButtonTapped(for view: DisposeClothesViewController) {
        view.delegate = self
        
        guard let category = category else { return }
        print("Category: \(category.name) has \(category.quantity) items BEFORE donating")
        
        guard let intString = disposeQuantityTextField.text, intString != "", intString != "0" else { disposedNumber = 0; return }
            let disposeInt = Int(intString)
        guard let disposedIntNumber = disposeInt else { disposedNumber = 0; return }
            // disponseNum = disposedIntNumber
            disposedNumber = disposedIntNumber
       // DisposeController.shared.updateTotalItemsDisposed(disposeNum: disposedIntNumber)
    }
    func clearDisposeTextField(for view: DisposeClothesViewController) {
        view.delegate = self
        //disposedNumber = 0 
        disposeQuantityTextField.text = ""
    }
}
