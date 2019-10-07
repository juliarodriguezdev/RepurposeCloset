//
//  ContributionsTableViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/23/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ContributionsTableViewCell: UITableViewCell {
    
    var contribution: Contribution?
    
    @IBOutlet weak var placeLabel: ClosetLabel!
    @IBOutlet weak var typeLabel: ClosetLabel!
    @IBOutlet weak var quantityLabel: ClosetLabel!
    @IBOutlet weak var timestampLabel: ClosetLabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //updateViews()
    }
    func updateViews() {
        guard let contribution = contribution else {
            self.placeLabel.text = "Store Name / Organization"
            self.typeLabel.text = "Type: Donation"
            self.quantityLabel.text = "0 items donated"
            self.timestampLabel.text = "Today at 12:00pm"
            self.imageIcon.image = UIImage(named: "donateContribution")
            return
        }
        var isDonated: String {
            if contribution.isDonation {
                let stringIsDonated = "Donatation"
                return stringIsDonated
            } else {
                return "Recycle"
            }
        }
        var contributionDescription: String {
            if contribution.isDonation {
                let donation = "donated"
                return donation
            } else {
                return "recycled"
            }
        }
        
        var imageName: String {
            if contribution.isDonation {
                return "donateContribution"
            } else {
                return "recycleContribution"
            }
        }
        
        var recieptCheck: String {
            if contribution.receiptImage == UIImage(named: "receiptLarge") {
                return "No"
            } else {
                return "Yes"
            }
        }
        self.placeLabel.text = contribution.place
        self.typeLabel.text = "Type: " + isDonated
        self.quantityLabel.text = "\(contribution.diposedAmount) items " + contributionDescription
        self.timestampLabel.text = contribution.timestamp.formatDate()
        self.imageIcon.image = UIImage(named: imageName)
        
        
    }

}
