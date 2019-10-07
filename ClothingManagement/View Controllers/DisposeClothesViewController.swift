//
//  DisposeClothesViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/21/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

protocol DisposeClothesViewControllerDelegate: class {
    func confirmDisposeButtonTapped(for view: DisposeClothesViewController)
}

class DisposeClothesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var disposeButton: ClosetButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    weak var delegate: DisposeClothesViewControllerDelegate?
    var user: User?

    // landing pad
   var recyclePlace: Recycle?
   var donationPlace: LocalDonation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //TODO: check if we need this
        //self.modalPresentationStyle = .overCurrentContext
        checkGenderForUIColor(user: user)
        cancelButton.setTitle("No, Not now. ", for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        checkIfDonationOrRecycle(recyclePlace: recyclePlace, donationPlace: donationPlace)
        
        // fetch the categories
        // call fetch function of categories
        guard let user = user else { return }
             CategoryController.shared.fetchCategories(user: user) { (category) in
                if category != nil {
                     DispatchQueue.main.async {
                        self.tableView.reloadData()
    
                     }
                 }
             }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkGenderForUIColor(user: user)
        checkIfDonationOrRecycle(recyclePlace: recyclePlace, donationPlace: donationPlace)
    }
    
    func checkIfDonationOrRecycle(recyclePlace: Recycle?, donationPlace: LocalDonation?) {
        if let donation = donationPlace {
            placeLabel.text = "Donate at " + donation.name
            disposeButton.setTitle("Donate Here", for: .normal)
        } else if let recycled = recyclePlace {
            placeLabel.text = "Recycle at " + recycled.storeName
            disposeButton.setTitle("Recycle Here", for: .normal)
        }
    }
    

    func checkGenderForUIColor(user: User?) {
        
        if user?.isMale == true {
            placeLabel.backgroundColor = UIColor.maleSecondary
            tableView.backgroundColor = UIColor.malePrimary
               
            } else if user?.isMale == false {
            placeLabel.backgroundColor = UIColor.femaleSecondary
            tableView.backgroundColor = UIColor.femalePrimary
            
            } else {
            placeLabel.backgroundColor = UIColor.neutralSecondary
            tableView.backgroundColor = UIColor.neutralPrimary
                
            }
        }

    
    func checkIfDonated() -> Bool {
        if let donatedPlace = donationPlace {
            print(donatedPlace)
            return true
        } else if let recyclePlace = recyclePlace {
            print(recyclePlace)
            return false
        }
        // default value 
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                // 1/4th of view
                self.view.frame.origin.y -= keyboardSize.height/3.3
                    //keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categories = CategoryController.shared.categories
        let filteredCategories = categories.filter { $0.quantity > 0}

        return user == nil ? 1 : filteredCategories.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // "disposeCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "disposeCell", for: indexPath) as? DisposeClothesTableViewCell else { return UITableViewCell() }
        if self.user == nil {
            cell.categoryLabel.text = "Closet Category"
            cell.quantityLabel.text = "Contains: 0 items"
            cell.backgroundColor = UIColor.neutralPrimary
            cell.disposeQuantityTextField.backgroundColor = UIColor.neutralPrimary
            return cell
        } else {
            let singleCategory = CategoryController.shared.categories
            let singleFilteredCategories = singleCategory.filter{ $0.quantity > 0 }
            let disposableCategory = singleFilteredCategories[indexPath.row]
        cell.category = disposableCategory
            if user?.isMale == true {
                cell.backgroundColor = UIColor.malePrimary
                cell.disposeQuantityTextField.backgroundColor = UIColor.malePrimary
            } else if user?.isMale == false {
                cell.backgroundColor = UIColor.femalePrimary
                cell.disposeQuantityTextField.backgroundColor = UIColor.femalePrimary
            }
        cell.updateViews()
        return cell
    }
       }
    
    @IBAction func disposeButtonTapped(_ sender: Any) {
        // grab the quantities in the text field, subtract them from the current quantity, and update the category
        if self.user != nil {
            var totalDispose: Int = 0
             // call the contribution controller to save a donation
             for cell in self.tableView.visibleCells {
                 if let customCell = cell as? DisposeClothesTableViewCell {
                     customCell.confirmDisposeButtonTapped(for: self)
                     //delegate?.confirmDisposeButtonTapped(for: self)
                    guard let category = customCell.category else { return }
                    //if customCell.disposedNumber <= customCell.category?.quantity
                    if let clothesDisposed = customCell.disposedNumber, clothesDisposed <= category.quantity {
            
                        totalDispose += clothesDisposed
                        DisposeController.shared.subtractDisposeQuantity(disposeValue: clothesDisposed, category: category)
                        
                         print("total diposed is \(totalDispose)")
                         print(customCell)
                    } else {
                        presentUIHelperAlert(title: "Invalid Entry", message: "The # entered exceeds \ntotal items in category")
                        DispatchQueue.main.async {
                            customCell.clearDisposeTextField(for: self)
                        }
                        //dismiss(animated: true)
                        return
                    }
                 }
             }
            
             guard let user = user else {
                 showSignUpViewController()
                 dismiss(animated: true)
                 return
             }
             let isDonated = self.checkIfDonated()
             
             if isDonated { // Donated
                guard let donatedPlace = donationPlace else { return }
                if totalDispose > 0 {
                    ContributionController.shared.createContribution(withName: donatedPlace.name, isDonated: true, disposedAmount: totalDispose, user: user) { (contribution) in
                        if contribution != nil {
                            print("successfully saved \(totalDispose) items to donatation at \(donatedPlace.name)")
                        }
                    }
                    self.showCelebrateViewControllerForDonation()
                    dismiss(animated: true)
                    return
                    
                } else {
                    // alert
                    presentUIHelperAlert(title: "Invalid Entry", message: "No items to donate, \nenter an amount and try agian")
                }
               
                 
                
             } else if !isDonated { // Recycled
                guard let recyclePlace = recyclePlace else { return }
                if totalDispose > 0 {
                    ContributionController.shared.createContribution(withName: recyclePlace.storeName, isDonated: false, disposedAmount: totalDispose, user: user) { (contribution) in
                        if contribution != nil {
                            print("successfully saved \(totalDispose) items to recycle facility at \(recyclePlace.storeName)")
                        }
                    }
                    self.showCelebrateViewControllerForRecycle()
                    dismiss(animated: true)
                    return
                } else {
                    presentUIHelperAlert(title: "Invalid Entry", message: "No items to recycle, \nenter an amount and try again")
                }
                
             }
            // user != nil ends func
        } else {
            presentUIHelperAlert(title: "Access Denied", message: "create an account to execute this feature")
            dismiss(animated: true)
            return
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func showSignUpViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        guard let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        self.present(signUpViewController, animated: true)
    }
    
    func showCelebrateViewControllerForDonation() {
        // present sign up View Controller
        let storyBoard = UIStoryboard(name: "TabMain", bundle: nil)
        guard let celebrateViewController = storyBoard.instantiateViewController(withIdentifier: "CelebrateViewController") as? CelebrateViewController else { return }
        celebrateViewController.user = user
        celebrateViewController.donationPlace = donationPlace
        self.present(celebrateViewController, animated: true)
        modalPresentationStyle = .overCurrentContext
    }
    func showCelebrateViewControllerForRecycle() {
           // present sign up View Controller
           let storyBoard = UIStoryboard(name: "TabMain", bundle: nil)
           guard let celebrateViewController = storyBoard.instantiateViewController(withIdentifier: "CelebrateViewController") as? CelebrateViewController else { return }
           celebrateViewController.user = user
           celebrateViewController.recyclePlace = recyclePlace
           self.present(celebrateViewController, animated: true)
            modalPresentationStyle = .overCurrentContext
       }
    func presentUIHelperAlert(title: String, message: String) {
          
          let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
          
          let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
          
          alertController.addAction(okayAction)
          self.present(alertController, animated: true)
      }

}

