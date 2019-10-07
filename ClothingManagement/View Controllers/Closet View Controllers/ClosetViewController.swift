//
//  ClosetViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/9/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ClosetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var quantityOfClosetLabel: UILabel!
    
    @IBOutlet weak var indicatior: UIActivityIndicatorView!
    // landing pad from other views
    var user = UserController.shared.currentUser
    
    var quantity: Int?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        // test for no user
        disableTapsOnCollectionView()
        self.quantityOfClosetLabel.text = "Loading..."
        checkGenderForUIColor(user: user)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 1
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.delegate = self
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
        // call fetch function of categories
        guard let user = user else {
            self.navigationItem.title = "Closet Name"
            self.indicatior.stopAnimating()

            return
        }
       
        indicatior.hidesWhenStopped = true
        indicatior.startAnimating()
        CategoryController.shared.fetchCategories(user: user) { (category) in
            if category != nil {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 2, delay: 0.1, options: .curveEaseIn, animations: {
                        
                        self.updateViews()
                        //self.collectionView.allowsSelection = true
                        //self.disableTapsOnCollectionView()
                        self.indicatior.stopAnimating()
                    })
                    
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        disableTapsOnCollectionView()
        updateViews()
    }
    func disableTapsOnCollectionView() {
        if user == nil {
            self.collectionView.allowsSelection = false
            self.quantityOfClosetLabel.text = "Contains 0 items"
        } else {
            self.collectionView.allowsSelection = true
        }
    }

    func updateViews() {
        guard let title = UserController.shared.currentUser?.closetName else { return }
        quantity = CategoryController.shared.calculateNumOfItemsInCloset(categories: CategoryController.shared.categories)
        self.navigationItem.title = "\(title)"
        UIView.animate(withDuration: 2) {
            self.quantityOfClosetLabel.text = "Contains \(self.quantity!) items in Closet"
        }
        self.collectionView.reloadData()
    }
    func checkGenderForUIColor(user: User?) {
        
        if user?.isMale == true {
            self.view.backgroundColor = UIColor.malePrimary
        } else if user?.isMale == false {
            self.view.backgroundColor = UIColor.femalePrimary
        } else {
            self.view.backgroundColor = UIColor.neutralPrimary
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categoryCount = CategoryController.shared.categories.count
        //TODO: test with no user 
        return user == nil ? 1 : categoryCount
        //return categoryCount == 0 ? 1 : categoryCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clothingItem", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        if self.user == nil  {
            cell.backgroundColor = UIColor.neutralPrimary
            cell.iconBackgroundView.backgroundColor = UIColor.neutralAccent?.withAlphaComponent(0.55)
            cell.categoryLabel.text = "Category"
            cell.quantityLabel.text = "0"
            cell.iconImage.image = UIImage(named: "hangerFinal-29")
            return cell
        } else if user?.isMale == true {
            cell.backgroundColor = UIColor.malePrimary
            cell.iconBackgroundView.backgroundColor = UIColor.maleAccent?.withAlphaComponent(0.7)
            let category = CategoryController.shared.categories[indexPath.item]
            cell.category = category
            cell.updateViews()
            return cell
        } else if user?.isMale == false {
            cell.backgroundColor = UIColor.femalePrimary
            cell.iconBackgroundView.backgroundColor = UIColor.femaleAccent?.withAlphaComponent(0.7)
            let category = CategoryController.shared.categories[indexPath.item]
            cell.category = category
            cell.updateViews()
            return cell
        }
        return cell
    }
    
    @IBAction func addCategoryTapped(_ sender: UIBarButtonItem) {
        if user != nil {
           presentAddCategory(title: "Category", message: "Add Category to Closet")
        } else {
            showSignUpViewController()
        }
        
    }
    
    
    func showAccountEditViewController() {
        let storyBoard = UIStoryboard(name: "TabMain", bundle: nil)
        guard let accountEditViewController = storyBoard.instantiateViewController(withIdentifier: "AccountEditViewController") as? AccountEditViewController else { return }
        self.present(accountEditViewController, animated: true)
        self.modalPresentationStyle = .overCurrentContext
        accountEditViewController.user = user
        
    }
    
    func showSignUpViewController() {
           // present sign up View Controller
           let storyBoard = UIStoryboard(name: "Main", bundle: .main)
           guard let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
           self.present(signUpViewController, animated: true)
       }
    
    func presentAddCategory(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Add Category Name..."
            textfield.returnKeyType = .continue
            textfield.autocapitalizationType = .sentences
            textfield.autocapitalizationType = .words
            
        }
        alertController.addTextField { (quantityTextField) in
            quantityTextField.placeholder = "Add Quantity of Clothes..."
            quantityTextField.keyboardType = .numberPad
            quantityTextField.returnKeyType = .done
            
            
        }
        let categoryAction = UIAlertAction(title: "Add", style: .default) { (_) in
            self.indicatior.startAnimating()
            var newCategory: String = ""
            var newQuantity: Int = 0
            if let categoryText = alertController.textFields?[0].text, !categoryText.isEmpty {
                newCategory = categoryText
            } else {
                // helper ui
                self.presentUIHelperAlert(title: "Invalid Entry", message: "Category name cannot be empty, try again.")
                self.indicatior.stopAnimating()
                return
            }
            
            if let stringQuantity = alertController.textFields?[1].text, !stringQuantity.isEmpty {
                guard let intQuantity = Int(stringQuantity) else { return }
                newQuantity = intQuantity
            } else {
                newQuantity = 0
            }
            guard let user = UserController.shared.currentUser else { return }
    
            CategoryController.shared.createCategory(withName: newCategory, quantity: newQuantity, user: user, completion: { (categoryFromCompletion) in
                if categoryFromCompletion != nil {
                    DispatchQueue.main.async {
                        //self.collectionView.reloadData()
                        self.updateViews()
                        self.indicatior.stopAnimating()
                        //self.disableTapsOnCollectionView()
                        
                    }
                }
            })
        }
        // add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // add all actions to alert controller
        alertController.addAction(categoryAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    @IBAction func deleteOptionTapped(_ sender: UIBarButtonItem) {
        presentUIHelperAlert(title: "Delete Category", message: "Press and hold individual category to delete")
    }
    
    @IBAction func infoTapped(_ sender: UIBarButtonItem) {
        presentUIHelperAlert(title: "Edit Category", message: "Select a category \nto upload photos & modify inventory")
    }
    
    //MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            // identify indexpath user selected
            if CategoryController.shared.categories.count >= 1 {
                if let destinationVC = segue.destination as? DetailCategoryViewController {
                    // identify cell user selected
                    if let cell = sender as? CategoryCollectionViewCell {
                        if let indexPath = collectionView.indexPath(for: cell) {
                            let category = CategoryController.shared.categories[indexPath.item]
                            destinationVC.category = category
                            destinationVC.user = user
                            
                        }
                    }
                }
            }
            
        }
        
        
        if segue.identifier == "toAccountVC" {
            if self.user == nil {
                showSignUpViewController()
                //presentUIHelperAlert(title: "Access Denied", message: "Create an account to edit account details")
                return
            } else {
                if let destinationVC = segue.destination as? AccountEditViewController {
                    destinationVC.user = user
                }
            }
        }
    }
}

extension ClosetViewController: UIGestureRecognizerDelegate {
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {

        let point = gestureRecognizer.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        if let index = indexPath {
            
            let category = CategoryController.shared.categories[index.item]
            
            presentDeleteCellConfirmation(title: "Delete Confirmation", message: "Are you sure you want to permanently delete the \(category.name)'s category from your closet?", indexPath: indexPath)
        }
        
    }
    
    func presentDeleteCellConfirmation(title: String, message: String, indexPath: IndexPath?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // No action
        let noAction = UIAlertAction(title: "No, Keep.", style: .cancel, handler: nil)
        // Delete action
        let deleteAction = UIAlertAction(title: "Yes, Delete.", style: .destructive) { (_) in
            if let index = indexPath {
                let cell = self.collectionView.cellForItem(at: index)
                //cell?.tintColor = UIColor.red
                cell?.backgroundColor = UIColor.red
                cell?.alpha = 0.9
                //print(cell)
                let category = CategoryController.shared.categories[index.item]
                CategoryController.shared.deleteCategory(category: category) { (success) in
                    if success {
                        DispatchQueue.main.async {
                            self.collectionView.deleteItems(at: [index])
                            self.updateViews()
                        }
                    }
                }
            } else {
                print("Couldn't find index path")
            }
        }
        
        // add all actions to alert controller
        alertController.addAction(noAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true)
    }
    
    func presentUIHelperAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(okayAction)
        self.present(alertController, animated: true)
    }
    
}
