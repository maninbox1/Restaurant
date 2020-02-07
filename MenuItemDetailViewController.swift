//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Mikhail Ladutska on 1/30/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    
    var menuItem: MenuItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        guard let menuItem = menuItem else {return}
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        detailTextLabel.text = menuItem.detailText
        addToOrderButton.layer.cornerRadius = 5.0
        
        MenuController.shared.fetchImage(url: menuItem.imageUrl) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    //MARK: IBActions
    
    @IBAction func addToOrderTapped(_ sender: UIButton) {
        guard let menuItem = menuItem else {return}
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            
            self.addToOrderButton.transform = CGAffineTransform.identity
            MenuController.shared.order.menuItems.append(menuItem)
        }
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        guard let menuItem = menuItem else {return}
        
        coder.encode(menuItem.id, forKey: "menuItemId")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        let menuItemID = Int(coder.decodeInt32(forKey: "menuItemId"))
        menuItem = MenuController.shared.item(withID: menuItemID)!
        updateUI()
    }
    
    
}
