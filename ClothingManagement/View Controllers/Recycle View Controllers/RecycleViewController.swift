//
//  RecycleViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class RecycleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let user = UserController.shared.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gestureRecognizer:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delaysTouchesBegan = true
        doubleTapGestureRecognizer.delegate = self
        self.tableView.addGestureRecognizer(doubleTapGestureRecognizer)
       
        checkGenderForUIColor(user: user)
    }
    
    func checkGenderForUIColor(user: User?) {
        if user?.isMale == true {
            tableView.backgroundColor = UIColor.malePrimary
        } else if user?.isMale == false {
            tableView.backgroundColor = UIColor.femalePrimary
        } else {
            tableView.backgroundColor = UIColor.neutralPrimary
        }
        
    }
    
    @IBAction func infoBarItemTapped(_ sender: UIBarButtonItem) {
        presentUIHelperAlert(title: "Information", message: "Single Tap: launches store's webpage for details \nDouble Tap: Enter # of recycled items")
    }
    
    func presentUIHelperAlert(title: String, message: String) {
         
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
         let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
         
         alertController.addAction(okayAction)
         self.present(alertController, animated: true)
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return RecycleController.shared.loadContent().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return RecycleController.shared.loadContent()[section].count
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let headerlabel = UILabel(frame: CGRect(x: 12, y: -3, width: tableView.frame.size.width, height: 35))

            if user?.isMale == true {
                view.backgroundColor = UIColor.maleAccent?.withAlphaComponent(0.9)
                headerlabel.textColor = UIColor.black
            } else if user?.isMale == false {
                view.backgroundColor = UIColor.femaleAccent?.withAlphaComponent(0.9)
                headerlabel.textColor = UIColor.black
            } else {
                view.backgroundColor = UIColor.neutralAccent?.withAlphaComponent(0.9)
                headerlabel.textColor = UIColor.black
            }
        headerlabel.font = UIFont(name: FontNames.trebuchetMS, size: 18)
        headerlabel.textAlignment = .left
        view.addSubview(headerlabel)
        
        switch section {
        case 0:
           headerlabel.text = "Clothes"
        case 1:
        headerlabel.text = "Denim"
        case 2:
            headerlabel.text = "Shoes"
        case 3:
            headerlabel.text = "Career Attire"
        case 4:
            headerlabel.text = "Bras"
        case 5:
            headerlabel.text = "Wedding Gowns"
        case 6:
            headerlabel.text = "Prom Dresses"
        default:
            headerlabel.text = "default section"
            return nil
        }
        return view
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recycleCell", for: indexPath) as? RecycleTableViewCell
        
        let recyclePlace = RecycleController.shared.loadContent()[indexPath.section][indexPath.row]
        if user?.isMale == true {
            cell?.backgroundColor = UIColor.malePrimary
        } else if user?.isMale == false {
            cell?.backgroundColor = UIColor.femalePrimary
        } else {
            cell?.backgroundColor = UIColor.neutralPrimary
        }
        cell?.storeNameLabel.textColor = UIColor.black
        cell?.initiativeNameLabel.textColor = UIColor.gray
        cell?.storeImage.image = recyclePlace.logoImage
        cell?.storeNameLabel.text = recyclePlace.storeName
        cell?.initiativeNameLabel.text = "Initiative: \(recyclePlace.initiative!)"
        cell?.storeImage.image = recyclePlace.logoImage
        return cell ?? UITableViewCell()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebView" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            let destinationVC = segue.destination as? RecycleWebViewController
            let recyclePlace = RecycleController.shared.loadContent()[index.section][index.row]
            destinationVC?.recyclePlace = recyclePlace
        }
    }
}

extension RecycleViewController: UIGestureRecognizerDelegate {
    @objc func doubleTap(gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }
    
        let point = gestureRecognizer.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: point)
        if let index = indexPath {
            // get the index path of the array (object to send)
            let recyclePlace = RecycleController.shared.loadContent()[index.section][index.row]
            let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
                guard let disposeClothesViewController = storyBoard.instantiateViewController(withIdentifier: "DisposeClothesViewController") as? DisposeClothesViewController else { return }
                // object to set
            disposeClothesViewController.recyclePlace = recyclePlace
            disposeClothesViewController.user = user
            
            // present modally
            navigationController?.present(disposeClothesViewController, animated: true)

        }
    }
}
