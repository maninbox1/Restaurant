//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Mikhail Ladutska on 2/5/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var minutes: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
    }
   
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
