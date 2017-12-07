//
//  NotificationsViewController.swift
//  SwiftDesignPatterns
//
//  Created by Andrei Ionescu on 06/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    @IBOutlet var notificationLabel: UILabel!
    let notificationKey = "com.andreitudorionescu.notificationKey"

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(NotificationsViewController.updateNotificationLabel), name: NSNotification.Name(rawValue: notificationKey), object: nil)
    }
    
    @objc func updateNotificationLabel() {
        self.notificationLabel.text = "Notification sent! (check previous screen as well)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendNotification(sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationKey), object: self)

    }
    
    @IBAction func removeObserverOnThisVC(sender: UIButton) {
        NotificationCenter.default.removeObserver(self)
    }
    


}
