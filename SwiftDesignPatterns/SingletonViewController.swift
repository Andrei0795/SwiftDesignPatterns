//
//  SingletonViewController.swift
//  SwiftDesignPatterns
//
//  Created by Andrei Ionescu on 07/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//

import UIKit
import AVFoundation

//This class is a singleton. Our intention is to play a single sound at any time
class MediaPlayerManeger {
    static let sharedInstance = MediaPlayerManeger()
    private var player: AVAudioPlayer?
    
    func playSound(resource: String) {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


class SingletonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Singleton"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sound1ButtonTapped(sender: UIButton) {
        MediaPlayerManeger.sharedInstance.playSound(resource: "birds")
    }
    
    @IBAction func sound2ButtonTapped(sender: UIButton) {
        MediaPlayerManeger.sharedInstance.playSound(resource: "dogs")
    }

}
