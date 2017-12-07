//
//  ExtensionsViewController.swift
//  SwiftDesignPatterns
//
//  Created by Andrei Ionescu on 07/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageFromURL(urlString: String) {
        
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let data = try? Data(contentsOf: url!)
            self.image = UIImage.init(data: data!)!
        }
    }
    
    func displayCreditsWhenImageTapped(creditsGoTo: String) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let viewController = appDelegate.window!.rootViewController

        let alert = UIAlertController(title: "Credits go to", message: creditsGoTo, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func addGestureRecogniser(imageTag: Int) {
        self.tag = imageTag
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.handleTapShowAlert))
        tap.delegate = self as? UIGestureRecognizerDelegate
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTapShowAlert(sender: UIGestureRecognizer) {
        
        var message = ""
        switch self.tag {
        case 0:
            message = "Pierre André Leclercq (Wikipedia) \n\n The city in the photo is Iasi, RO."
        case 1:
            message = "Mark Andrew (Flickr) \n\n The city in the photo is Manchester, UK."
        default:
            message = "No Credits"
        }
        
        self.displayCreditsWhenImageTapped(creditsGoTo: message)
    }
}

class ExtensionsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IMAGE 1
        self.imageView.setImageFromURL(urlString: "https://upload.wikimedia.org/wikipedia/commons/f/f2/Pia%C8%9Ba_Palat%2C_Ia%C8%99i%2C_Roumanie.jpg")
        self.imageView.addGestureRecogniser(imageTag: 0)
        
        
        //IMAGE 2
        self.imageView2.setImageFromURL(urlString: "https://upload.wikimedia.org/wikipedia/commons/7/7f/Manchester_Town_Hall_from_Lloyd_St.jpg")
        self.imageView2.addGestureRecogniser(imageTag: 1)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
