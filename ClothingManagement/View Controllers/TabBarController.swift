//
//  TabBarController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 10/1/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var user = UserController.shared.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .lightText
        self.tabBar.unselectedItemTintColor = .gray
        checkGenderForUIColor(user: user)
        tabBarController?.selectedIndex = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //checkGenderForUIColor(user: user)
    }
    
    func checkGenderForUIColor(user: User?) {
           
           if user?.isMale == true {
             self.tabBar.barTintColor = UIColor.maleSecondary
           } else if user?.isMale == false {
            self.tabBar.barTintColor = UIColor.femaleSecondary
           } else {
            self.tabBar.barTintColor = UIColor.neutralSecondary
           }
       }

}

