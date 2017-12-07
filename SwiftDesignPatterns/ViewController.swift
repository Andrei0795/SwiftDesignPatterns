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
    let notificationKey = "com.andreitudorionescu.notificationKey"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateNotificationTitleLabel), name: NSNotification.Name(rawValue: notificationKey), object: nil)

    }
    
    @objc func updateNotificationTitleLabel() {
        self.titleLabel.text = "Notification sent here too!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

