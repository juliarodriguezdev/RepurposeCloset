//
//  SignUpViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var signUpLabel: ClosetLabel!
    
    @IBOutlet weak var descriptionLabel: ClosetLabel!
    
    @IBOutlet weak var nameTextField: ClosetTextField!
    
    @IBOutlet weak var closetNameTextField: ClosetTextField!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var skipLabel: ClosetLabel!
    
    @IBOutlet weak var createAccountButton: ClosetButton!
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var informationOnBoarding: UIView!
    
    @IBOutlet weak var infoTextLabel: UILabel!
    
    @IBOutlet weak var startButton: ClosetButton!
    
    
    var isMale: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        closetNameTextField.delegate = self
        signUpLabel.text = "Sign up!"
        descriptionLabel.text = "Save closet inventory, upload clothing photos, track donated \n& recyled contributions to the greater world"
        skipLabel.text = "Browse the app, \nwithout creating an account..."
        skipLabel.alpha = 0
        infoTextLabel.text = "Click on the info icon to navigate through app features: \n\n• Tap gestures \n• Update closet inventory \n• Upload clothing photos \n• Donate clothing \n• Recycle clothing \n• Manage contributions \n• Upload tax deductible receipts"
        informationOnBoarding.alpha = 0
        skipLabel.addCornerRadius(10)
        updateFontSizeAndSegControl(with: "Trebuchet MS")
        updateColorUI()
    }
    func updateFontSizeAndSegControl(with fontName: String) {
       
        signUpLabel.font = signUpLabel.font.withSize(24)
        descriptionLabel.font = descriptionLabel.font.withSize(18)
        nameTextField.font = nameTextField.font?.withSize(14)
        closetNameTextField.font = closetNameTextField.font?.withSize(14)
        skipLabel.font = closetNameTextField.font?.withSize(20)
        createAccountButton.titleLabel?.font = createAccountButton.titleLabel?.font.withSize(20)
        skipButton.titleLabel?.font = skipButton.titleLabel?.font.withSize(18)
        let segmentedFont = UIFont(name: fontName, size: 16)
        genderSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: segmentedFont!], for: .normal)
        genderSegmentedControl.addCornerRadius(10)
    }
    
    func updateColorUI() {
        self.view.backgroundColor = UIColor.neutralPrimary
        //skipLabel.backgroundColor = UIColor.neutralSecondary
        createAccountButton.backgroundColor = UIColor.neutralAccent
        createAccountButton.setTitleColor(.lightText, for: .normal)
        skipButton.backgroundColor = UIColor.neutralPrimary
        skipButton.setTitleColor(.darkText, for: .normal)
        skipLabel.textColor = .darkGray
        //skipLabel.backgroundColor = .lightGray
        nameTextField.backgroundColor = UIColor.neutralPrimary
        closetNameTextField.backgroundColor = UIColor.neutralPrimary
    }

    @IBAction func genderSegmentedControl(_ sender: UISegmentedControl) {

        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            return isMale = true
        case 1:
            return isMale = false
        default:
            print("Not able to grab a gender")
            break
        }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        // call no icloud account
        checkforiCloudUserPresence()
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            self.isMale = true
        } else if genderSegmentedControl.selectedSegmentIndex == 1 {
            self.isMale = false
        }
        
        guard let userName = nameTextField.text, !userName.isEmpty,
            let closetName = closetNameTextField.text, !closetName.isEmpty,
            let isMale = isMale
            else {
                // Add alert sheet to show something is missing 
                self.presentCreateAccountInfoMissing()
                return
                
        }
        
        
        UserController.shared.createUserWith(userName: userName, closetName: closetName, isMale: isMale) { (user) in
            if user != nil {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1) {
                        if user?.isMale == true {
                            self.startButton.backgroundColor = UIColor.maleAccent
                        } else {
                            self.startButton.backgroundColor = UIColor.femaleAccent
                        }
                        self.informationOnBoarding.alpha = 1
                    }
                }
            }
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        closetNameTextField.resignFirstResponder()
    }
    
    func presentCreateAccountInfoMissing() {
        let attributedString = NSAttributedString(string: "Information Missing", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), //your font here
            NSAttributedString.Key.foregroundColor : UIColor.red,
        ])
        
        let alertController = UIAlertController(title: "", message: "Please enter all fields, \n to continue to create an account.", preferredStyle: .alert)
        alertController.setValue(attributedString, forKey: "attributedTitle")
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        okAction.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        // send to main closet
        skipLabel.alpha = 1
        
        UIView.animate(withDuration: 0, delay: 3, options: .curveEaseIn, animations: {
            self.skipLabel.alpha = 0
        }) { (completion) in
            if completion {
                self.showMainNavController()
            }
        }

    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        showMainNavController()
    }
    
    
    func showMainNavController() {
            let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
            let mainNavController = storyBoard.instantiateViewController(withIdentifier: "mainTabController")
        mainNavController.modalPresentationStyle = .overFullScreen
            self.present(mainNavController, animated: true)
       }
   
    func checkforiCloudUserPresence() {
        CKContainer.default().accountStatus { (status, error) in
            if let error = error {
                print("error fetching iCloud account: \(error.localizedDescription)")
            } else {
                switch status{
                case .available:
                    print("iCloud account is available")
                case .restricted:
                    print("iCloud account is restricted")
                case .noAccount:
                    // present no iCloud VC
                    self.presentNoiCloudAccountViewController()
                case .couldNotDetermine:
                    print("iCloud account could not be determined")
                default:
                    print("icloud Error ")
                }
            }
        }
    }
    
    func presentNoiCloudAccountViewController() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let noiCloudViewController = storyboard.instantiateViewController(withIdentifier: "noiCloudAccountViewController") as? noiCloudAccountViewController else { return }
            self.present(noiCloudViewController, animated: true)
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocapitalizationType = .words
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
