//
//  UpgradeViewController.swift
//  IAPDemo
//
//  Created by Hesham Abd-Elmegid on 8/18/16.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import UIKit

class UpgradeViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var upgradeButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!

    override func viewDidAppear(animated: Bool) {
        UpgradeManager.sharedInstance.priceForUpgrade { (price) in
            self.priceLabel.text = "$\(price)"
            self.upgradeButton.enabled = true
            self.restoreButton.enabled = true
        }
    }

    @IBAction func doneButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func upgradeButtonTapped(sender: AnyObject) {
        UpgradeManager.sharedInstance.upgrade { (succeeded) -> (Void) in
            if succeeded {
                let alertController = UIAlertController(title: "Upgraded!", message: "Thanks for upgrading. You can now view quotes from famous people.", preferredStyle: .Alert)
                let doneAction = UIAlertAction(title: "Done", style: .Default, handler: { (action) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                
                alertController.addAction(doneAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func restorePurchasesButtonTapped(sender: AnyObject) {
        UpgradeManager.sharedInstance.restorePurchases { (succeeded) -> (Void) in
            if succeeded {
                let alertController = UIAlertController(title: "Restored!", message: "Your purchases have been restored. You can now view quotes from famous people.", preferredStyle: .Alert)
                let doneAction = UIAlertAction(title: "Done", style: .Default, handler: { (action) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                
                alertController.addAction(doneAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
