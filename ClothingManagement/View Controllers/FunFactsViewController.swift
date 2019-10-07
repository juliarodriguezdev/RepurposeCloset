//
//  FunFactsViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class FunFactsViewController: UIViewController {

    @IBOutlet weak var factsLabel: UILabel!
    
    @IBOutlet weak var nextTextileFact: UIButton!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var factsImage: UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        navigationItem.title = "Fun Facts"
        navigationItem.largeTitleDisplayMode = .always
        nextTextileFact.setTitle(" Next... ", for: .normal)
        nextTextileFact.addCornerRadius(8)
        nextTextileFact.addBorder()
        ClothingFactController.shared.loadClothingFacts()
        textileFacts()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ClothingFactController.shared.loadClothingFacts()
        textileFacts()
    }
    @IBAction func nextTextileFactPressed(_ sender: UIButton) {
        textileFacts()
    }
    
        
    func setLabelBackgroundColor(backrgroundColor: UIColor, textTint: UIColor, alpha: CGFloat) {
        factsLabel.alpha = alpha
        factsLabel.backgroundColor = backrgroundColor
        factsLabel.textColor = textTint
        sourceLabel.alpha = alpha
        sourceLabel.backgroundColor = backrgroundColor
        sourceLabel.textColor = textTint
    }
    func setNextTextileFactButton(backgroundColor: UIColor, textTint: UIColor, alpha: CGFloat) {
        nextTextileFact.backgroundColor = backgroundColor
        nextTextileFact.setTitleColor(textTint, for: .normal)
        nextTextileFact.alpha = alpha
    }
    func textileFacts() {
        let facts = ClothingFactController.shared.clothingFacts
        if let oneFact = facts.randomElement() {
            self.factsLabel.text = oneFact.fact
            self.sourceLabel.text = oneFact.source
            switch oneFact.type {
                //yes
            case .water:
                factsImage.image = UIImage(named: "water")
                setLabelBackgroundColor(backrgroundColor: .white, textTint: .black, alpha: 0.6)
                setNextTextileFactButton(backgroundColor: .white, textTint: .black, alpha: 0.7)
                //y
            case .dyes:
                factsImage.image = UIImage(named: "dyes")
                setLabelBackgroundColor(backrgroundColor: .white, textTint: .black, alpha: 0.65)
                setNextTextileFactButton(backgroundColor: .white, textTint: .black, alpha: 0.7)

              //y
            case .landfill:
                factsImage.image = UIImage(named: "trashWheels")
                setLabelBackgroundColor(backrgroundColor: .white, textTint: .black, alpha: 0.6)
                setNextTextileFactButton(backgroundColor: .white, textTint: .black, alpha: 0.7)

                //y
            case .oil:
                factsImage.image = UIImage(named: "oilPortrait")
                setLabelBackgroundColor(backrgroundColor: .white, textTint: .black, alpha: 0.55)
                setNextTextileFactButton(backgroundColor: .white, textTint: .black, alpha: 0.7)

            //y
            case .cotton:
                factsImage.image = UIImage(named: "cottonPortrait")
                setLabelBackgroundColor(backrgroundColor: .black, textTint: .white, alpha: 0.7)
                setNextTextileFactButton(backgroundColor: .black, textTint: .white, alpha: 0.8)

                //yes
            case .clothing:
                factsImage.image = UIImage(named: "mensClothes")
                setLabelBackgroundColor(backrgroundColor: .white, textTint: .black, alpha: 0.65)
                setNextTextileFactButton(backgroundColor: .white, textTint: .black, alpha: 0.7)

                //y
            case .playfields:
                factsImage.image = UIImage(named: "trackField")
                setLabelBackgroundColor(backrgroundColor: .white, textTint: .black, alpha: 0.6)
                setNextTextileFactButton(backgroundColor: .white, textTint: .black, alpha: 0.7)

                //y
            case .secondHand:
                factsImage.image = UIImage(named: "secondHandClothes")
                setLabelBackgroundColor(backrgroundColor: .white, textTint: .black, alpha: 0.7)
                setNextTextileFactButton(backgroundColor: .white, textTint: .black, alpha: 0.7)

                // y
            case .recycle:
                factsImage.image = UIImage(named: "recycle-1")
            setLabelBackgroundColor(backrgroundColor: .black, textTint: .white, alpha: 0.7)
                setNextTextileFactButton(backgroundColor: .black, textTint: .white, alpha: 0.8)
                //y
            case .pollution:
                factsImage.image = UIImage(named: "pollution")
                setLabelBackgroundColor(backrgroundColor: .white, textTint: .black, alpha: 0.6)
                setNextTextileFactButton(backgroundColor: .white, textTint: .black, alpha: 0.7)

                //y
            case .trees:
                factsImage.image = UIImage(named: "trees")
                setLabelBackgroundColor(backrgroundColor: .black, textTint: .white, alpha: 0.7)
                setNextTextileFactButton(backgroundColor: .black, textTint: .white, alpha: 0.6)


            }
        }
    }
}
