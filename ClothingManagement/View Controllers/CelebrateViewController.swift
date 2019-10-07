//
//  CelebrateViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/27/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class CelebrateViewController: UIViewController {
    // landing pad
    var user: User?
    
    var donationPlace: LocalDonation?
    
    var recyclePlace: Recycle?
    
    var celebrateText = ""
    
    @IBOutlet weak var celebrateLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        celebrateLabel.alpha = 0
        celebrateLabel.addCornerRadius(10)
        guard let user = user else { return }
        displayLabel(user: user, donationPlace: donationPlace, recyclePlace: recyclePlace)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = user else { return }
        displayLabel(user: user, donationPlace: donationPlace, recyclePlace: recyclePlace)
    }
    
    func displayLabel(user: User, donationPlace: LocalDonation?, recyclePlace: Recycle?) {
        
        if let donation = donationPlace {
            celebrateText = "\nThank you, \(user.name!), \nfor donating at \(donation.name)! \n\nYour closet items are starting a new life.\n "
        } else if let recycle = recyclePlace {
            
            celebrateText = "\nThank you, \(user.name!), for recyling at \(recycle.storeName)! \n\nYour closet items will be remade into something new.\n"
        }
        self.celebrateLabel.text = celebrateText
        self.celebrateLabel.alpha = 0.80
        UIView.animate(withDuration: 4, delay: 0, options: .curveEaseIn, animations: {
            DispatchQueue.main.async {
                self.celebrateLabel.alpha = 0
            }
            
        }) { (completion) in
            if completion {
                sleep(3)
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
                
            }
        }
    }
    
    func showContributionsViewController() {
             // present sign up View Controller
             let storyBoard = UIStoryboard(name: "TabMain", bundle: nil)
             guard let contributionsViewController = storyBoard.instantiateViewController(withIdentifier: "ContributionsViewController") as? ContributionsViewController else { return }
            self.show(contributionsViewController, sender: self)
             //self.present(contributionsViewController, animated: true)
         }

}
