//
//  NavigationViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 10/1/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    var user = UserController.shared.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNeedsStatusBarAppearanceUpdate()
        self.navigationBar.tintColor = .gray
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: FontNames.trebuchetMS, size: 20)!]

        checkGenderForUIColor(user: user)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: FontNames.trebuchetMS, size: 20)!]

        checkGenderForUIColor(user: user)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        navigationController?.navigationBar.barStyle = .black
//    }
    
    func checkGenderForUIColor(user: User?) {
        
        if user?.isMale == true {
            // background
            self.navigationBar.barTintColor = UIColor.maleSecondary
            
            
        } else if user?.isMale == false {
            // background
            self.navigationBar.barTintColor = UIColor.femaleSecondary
        
        } else {
            // background
            self.navigationBar.barTintColor = UIColor.neutralSecondary
           
        }
    }
    
}
