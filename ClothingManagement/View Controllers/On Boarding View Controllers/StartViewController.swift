//
//  StartViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/24/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFont(with: "Trebuchet MS")
        // fetch User
        indicator.startAnimating()
        updateColorUI()
        UserController.shared.fetchUser { (success) in
            if success == true {
                // send to closet view controller
                DispatchQueue.main.async {
                    self.showMainNavController()
                    self.indicator.stopAnimating()
                }
            } else {
                // send to sign up
                DispatchQueue.main.async {
                    self.showSignUpViewController()
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    
    func updateColorUI() {
        self.view.backgroundColor = UIColor.neutralPrimary
        indicator.color = .darkGray
        //titleLabel.textColor = UIColor.neutralPrimary
    }
    func showClosetViewController() {
        let storyBoard = UIStoryboard(name: "TabMain", bundle: nil)
        guard let mainClosetViewController = storyBoard.instantiateViewController(withIdentifier: "ClosetViewController") as? ClosetViewController else { return }
            // set closet object
            mainClosetViewController.user = UserController.shared.currentUser
            self.present(mainClosetViewController, animated: true)
    }
    
    func showMainNavController() {
               let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
               let mainNavController = storyBoard.instantiateViewController(withIdentifier: "mainTabController")
        mainNavController.modalPresentationStyle = .fullScreen
               self.present(mainNavController, animated: true)
          }
    
  
    func showSignUpViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        guard let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true)
    }
    
    func updateFont(with fontName: String) {
        titleLabel.font = UIFont(name: fontName, size: 16)
    }
}
