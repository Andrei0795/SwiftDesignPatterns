//
//  ViewController.swift
//  SwiftDesignPatterns
//
//  Created by Andrei Ionescu on 06/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    //For Notifications
    let notificationKey = "com.andreitudorionescu.notificationKey"
    //-----------------
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateNotificationTitleLabel), name: NSNotification.Name(rawValue: notificationKey), object: nil)
        //-----------------
        

    }
    
    //For Notifications
    @objc func updateNotificationTitleLabel() {
        self.titleLabel.text = "Notification sent here too!"
    }
    //-----------------
    
    //For Delegation
    
    //Please note that unlike other views, the segue for delegation is done programatically
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "delegationSegue" {
            let viewController = segue.destination as! DelegationViewController
            viewController.delegate = self
        }
    }
    
    @IBAction func delegationButtonTapped(sender: UIButton) {
        self.performSegue(withIdentifier: "delegationSegue", sender: self)
    }
    //--------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//For Delegation
extension ViewController: ChangeLabelDelegate {
    
    func buttonOnNextScreenTapped() {
        self.titleLabel.text = "Delegate updated this label 👍"
    }
    
}
//--------------

