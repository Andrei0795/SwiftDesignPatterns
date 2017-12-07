//
//  DelegationViewController.swift
//  SwiftDesignPatterns
//
//  Created by Andrei Ionescu on 07/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//

import UIKit

protocol ChangeLabelDelegate {
    func buttonOnNextScreenTapped()
}

class DelegationViewController: UIViewController {

    var delegate: ChangeLabelDelegate!
    @IBOutlet var tipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Delegation"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        delegate.buttonOnNextScreenTapped()
        tipLabel.text = "Delegate method fired! Check previous screen!"
    }

}
