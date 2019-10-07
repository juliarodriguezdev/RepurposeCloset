//
//  DetailCategoryViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation


class DetailCategoryViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    var category: Category?
    
    @IBOutlet weak var categoryLabel: ClosetLabel!
    
    @IBOutlet weak var quantityOfCategoryLabel: ClosetLabel!
    
    @IBOutlet weak var updateQuantityButton: UIButton!
    
    @IBOutlet weak var photoGalleryLabel: UILabel!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photoGalleryLabel.text = "Photo Gallery is loading..."
        
        guard let category = category else { return }
        updateViews()
        let predicate = NSPredicate(format: "categoryReference == %@", category.recordID)
        let compPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        CategoryPhotoController.shared.fetchCategoryPhotos(category: category, predicate: compPredicate) { (photos) in
            if let photos = photos {
                category.categoryPhotos = photos
                DispatchQueue.main.async {
                    // TODO: reload tableview
                    self.photosCollectionView.reloadData()
                    self.photoGalleryLabel.text = "Photo Gallery"
                }
            } else {
                print("Failed to retrieve photos")
            }
        }
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(gestureRecognizer:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delaysTouchesBegan = true
        doubleTapGestureRecognizer.delegate = self
        self.photosCollectionView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 1
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.delegate = self
        self.photosCollectionView.addGestureRecognizer(longPressGestureRecognizer)
        
        checkGenderForUIColor(user: user)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    @IBAction func updateQuantityButtonTapped(_ sender: UIButton) {
        // perform segue
        //self.performSegue(withIdentifier: "toUpdateQuantityVC", sender: self)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIBarButtonItem) {
        // TODO: add alert controller action sheet
        presentImagePickerActionSheet()
    }
    
    @IBAction func infoBarItemTapped(_ sender: UIBarButtonItem) {
        presentUIHelperAlert(title: "Information", message: "Camera: upload/capture photos \nPencil: update inventory # \nEdit: edit category name \nDouble Tap: on a photo to set it as the Closet icon image \nPress and Hold: to delete a photo.")
    }
    
    @IBAction func editBarItemTapped(_ sender: UIBarButtonItem) {
        // TODO: Test with a user 
        editCategoryTitleAlert()
    }
    
    
    func presentUIHelperAlert(title: String, message: String) {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            
            alertController.addAction(okayAction)
            self.present(alertController, animated: true)
        }
    
    
    func updateViews() {
        guard let category = category else { return }
        categoryLabel.text = "Category: \(category.name)"
        if category.quantity == 1 {
            quantityOfCategoryLabel.text = "Contains: \(category.quantity) "

        } else {
            quantityOfCategoryLabel.text = "Contains: \(category.quantity) items"
        }
      
    }
    func checkGenderForUIColor(user: User?) {
        
        if user?.isMale == true {
    
            updateQuantityButton.backgroundColor = UIColor.malePrimary
            //updateQuantityButton.tintColor = CustomUIColors.maleSecondary
            self.view.backgroundColor = UIColor.malePrimary
            photosCollectionView.backgroundColor = UIColor.malePrimary
            
        } else if user?.isMale == false {
            updateQuantityButton.backgroundColor = UIColor.femalePrimary
            updateQuantityButton.tintColor = UIColor.femaleSecondary
            self.view.backgroundColor = UIColor.femalePrimary
            photosCollectionView.backgroundColor = UIColor.femalePrimary
           
        } else {
            updateQuantityButton.backgroundColor = UIColor.neutralPrimary
            updateQuantityButton.tintColor = UIColor.neutralSecondary
            self.view.backgroundColor = UIColor.neutralPrimary
            photosCollectionView.backgroundColor = UIColor.neutralPrimary
           
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateQuantityVC" {
            let destinationVC = segue.destination as? UpdateQuantityViewController
            guard let category = category, let user = user else { return }
            destinationVC?.category = category
            destinationVC?.user = user

        }
    }
    
    func editCategoryTitleAlert() {
        guard let category = category else { return }
        let alertController = UIAlertController(title: "Edit Category Title", message: "Eenter a new title", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Edit Title here..."
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
            // TODO: Test current category name
            textField.keyboardAppearance = .alert
            textField.returnKeyType = .done
            textField.delegate = self

        }
        
        let addAction = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let editedTitle = alertController.textFields?.first?.text else { return }
            if editedTitle != category.name, !editedTitle.isEmpty {
                category.name = editedTitle
                CategoryController.shared.updateCategory(category: category) { (success) in
                    if success {
                        print("Category edited and updated")
                        DispatchQueue.main.async {
                            self.updateViews()
                        }
                    }
                }
                
            } else {
                // TODO: Show Alert : edited text is the same as previous text
                self.presentUIHelperAlert(title: "Invalid edited title", message: "Edited title is either empty or same as previous.")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}

extension DetailCategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentImagePickerActionSheet() {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Upload / Capture a photo", message: "select from options below...", preferredStyle: .actionSheet)
        
        
        // check if the photolibrary is available as a source
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                
                imagePickerController.sourceType = .photoLibrary
                //imagePickerController.allowsEditing = true
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                //imagePickerController.allowsEditing = true
                imagePickerController.showsCameraControls = true
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Users Camera not available")
                let alertController = UIAlertController(title: "Camera access not allowed", message: "In order to use your camera to upload photos to the closet, please go to your phone's settings and allow camera access", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.photoGalleryLabel.text = "Photo Gallery is loading..."
        
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
    
            guard let category = category else { return }
            
            CategoryPhotoController.shared.createCategoryPhoto(photo: photo, category: category) { (photo) in
                if let photo = photo {
                    print("Category photo saved successfully")
                    DispatchQueue.main.async {
                        category.categoryPhotos.append(photo)
                        self.photosCollectionView.reloadData()
                        self.photoGalleryLabel.text = "Photo Gallery..."
                    }
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }

}

extension DetailCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // guard let category = category else { return 0}
        return category?.categoryPhotos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? DetailCategoryCollectionViewCell else { return UICollectionViewCell()}
        
        let photo = category?.categoryPhotos[indexPath.item].categoryPhoto
        cell.photoImageView.image = photo
        cell.photoImageView.contentMode = .scaleAspectFit
    
        return cell
    }
    
}

extension DetailCategoryViewController: UIGestureRecognizerDelegate {
    @objc func handleDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
    
        guard let category = category else { print("Failed to get category"); return }
        let point = gestureRecognizer.location(in: self.photosCollectionView)
        let indexPath = self.photosCollectionView.indexPathForItem(at: point)

        if let index = indexPath {
            let cell = photosCollectionView.cellForItem(at: index)
            if user?.isMale == true {
                cell?.backgroundColor = UIColor.maleAccent
            } else if user?.isMale == false {
                cell?.backgroundColor = UIColor.femaleAccent
            } else {
                cell?.backgroundColor = UIColor.neutralAccent
            }
            // call and create a CRUD function to to this
            let iconPhoto = category.categoryPhotos[index.item].categoryPhoto
            category.iconImage = iconPhoto
    
            CategoryController.shared.updateCategory(category: category) { (success) in
                if success {
                    print("category: \(category.name) saved at Double Tap Gesture")
                    DispatchQueue.main.async {
                        self.presentUIHelperAlert(title: "Icon Saved!", message: "Image saved to category's icon on the Main Closet ")
                        cell?.backgroundColor = .clear
                    }
                    // TODO: show feedback label set alpha to 0 in viewDidLoad, set alpha to 1 here, animate for 5 sec. "Saved"
                }
            }
        } else {
                print("Failed to get indexPath at point")
            }
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
           if gestureRecognizer.state != UIGestureRecognizer.State.ended {
               return
           }
        guard let category = category else { return }
           let point = gestureRecognizer.location(in: self.photosCollectionView)
           let indexPath = self.photosCollectionView.indexPathForItem(at: point)
        
               // alert
            presentDeleteCellConfirmation(title: "Delete Confirmation", message: "Are you sure you wnat to permanently delete this photo?", indexPath: indexPath, category: category)
           
           
       }
    func presentDeleteCellConfirmation(title: String, message: String, indexPath: IndexPath?, category: Category) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // No action
        let noAction = UIAlertAction(title: "No, Keep.", style: .cancel, handler: nil)
        // Delete action
        let deleteAction = UIAlertAction(title: "Yes, Delete.", style: .destructive) { (_) in
            if let index = indexPath {
                let cell = self.photosCollectionView.cellForItem(at: index)
                //cell?.tintColor = UIColor.red
                cell?.backgroundColor = UIColor.red
                cell?.alpha = 0.9
                //print(cell)
                let photo = category.categoryPhotos[index.item]
                CategoryPhotoController.shared.deleteCategoryPhoto(categoryPhoto: photo, category: category) { (success) in
                    if success {
                        DispatchQueue.main.async {
                            self.photosCollectionView.deleteItems(at: [index])
                        }
                    } else {
                        print("Couldn't delete photo")
                    }
                }
            }
        }
        
        // add all actions to alert controller
        alertController.addAction(noAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true)
    } // end

}
