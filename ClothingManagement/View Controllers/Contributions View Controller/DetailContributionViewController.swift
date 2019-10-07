//
//  DetailContributionViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/24/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class DetailContributionViewController: UIViewController {
    
    var contribution: Contribution?
    
    var user: User?
    
    var isCamera = false
    var newPhoto = false
        
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var saveButton: ClosetButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var receiptImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        checkGenderForColorUI(user: user)
        
    }
    
    func rotateImageToPortrait(image: UIImageView) {
        image.transform = CGAffineTransform(rotationAngle: .pi/2)
    }
    
    func updateViews() {
        saveButton.setTitle("Save Receipt!", for: .normal)
        guard let contribution = contribution else {
            placeLabel.text = "For Clothing Donation at: Store Name"
            receiptImageView.image = UIImage(named: "receiptLarge")
            return
            
        }
        if contribution.isDonation == true {
            placeLabel.text = "For Clothing Donation at: " + contribution.place
        } else {
            placeLabel.text = "For Clothing Recyling at: " + contribution.place

        }
        
        receiptImageView.image = contribution.receiptImage
    }
    
    func checkGenderForColorUI(user: User?) {
        if user?.isMale == true {
            self.view.backgroundColor = UIColor.malePrimary
            editButton.tintColor = UIColor.maleSecondary
        } else if user?.isMale == false {
            self.view.backgroundColor = UIColor.femalePrimary
            editButton.tintColor = UIColor.femaleSecondary
        } else {
            self.view.backgroundColor = UIColor.neutralPrimary
            editButton.tintColor = UIColor.neutralSecondary
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        if contribution != nil {
            // show photo libray / camera to import receipt
            presentImagePickerActionSheet()
        } else {
            showSignUpViewController()
            return 
        }
        
    }
    
    
    @IBAction func saveReceiptButtonTapped(_ sender: UIButton) {
        if self.newPhoto == true, user != nil  {
            guard let contribution = contribution else {
                showSignUpViewController()
                return
            }
            let uploadedImage = receiptImageView.image
            contribution.receiptImage = uploadedImage
            //let filteredImage = convertToGrayScale(image: uploadedImage)
            //contribution.receiptImage = filteredImage
            saveButton.setTitle("Saving...", for: .normal)
            ContributionController.shared.updateContribution(contribution: contribution) { (success) in
                           if success {
                               print("Receipt saved!")
                            // TODO: show a pop up that it was saved successfully, alpha = 1, then alpha = 0
                            DispatchQueue.main.async {
                                self.saveButton.setTitle("Save Receipt!", for: .normal)
                                self.presentUIHelperAlert(title: "Saved!", message: "Receipt save succesfully")
                            }
                        }
                     
                    }
             // set photo to false at end
            self.newPhoto = false
           
        } else if user == nil {
            // add helper alert
            presentUIHelperAlert(title: "Access Denied", message: "Create an account to save receipt")
        } else {
            presentUIHelperAlert(title: "Cannot Save", message: "Please add a new photo")

        }
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func infoButtonTapped(_ sender: UIBarButtonItem) {
        
        presentUIHelperAlert(title: "Information", message: "Select camera to \nupload/capture receipt")
    }
    
    func showSignUpViewController() {
        // present sign up View Controller
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        guard let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        self.present(signUpViewController, animated: true)
    }
    
    func convertToGrayScale(image: UIImage) -> UIImage {

        // Create image rectangle with current image width/height
        let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)

        // Grayscale color space
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height

        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context!.makeImage()

        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef!)

        return newImage
    }
    
    func presentUIHelperAlert(title: String, message: String) {
           
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
           
           alertController.addAction(okayAction)
           self.present(alertController, animated: true)
       }
    

}

extension DetailContributionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentImagePickerActionSheet() {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Select a Receipt", message: "Choose from your photo libary, or camera", preferredStyle: .actionSheet)
        
        
        // check if the photolibrary is available as a source
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                
                self.isCamera = false
                imagePickerController.sourceType = .photoLibrary
                //imagePickerController.allowsEditing = true
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                //adds smaller rectangle
                //imagePickerController.allowsEditing = true
                self.isCamera = true
                imagePickerController.showsCameraControls = true
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Users Camera not available")
                let alertController = UIAlertController(title: "Camera access not allowe", message: "In order to use your camera to upload a receipt, please go to your phone's settings and allow camera access", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.newPhoto = true
            let blackWhiteImage = convertToGrayScale(image: image)
            self.receiptImageView.image = blackWhiteImage
            if isCamera { rotateImageToPortrait(image: receiptImageView) }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
}

