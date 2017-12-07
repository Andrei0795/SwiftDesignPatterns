//
//  MVCViewController.swift
//  SwiftDesignPatterns
//
//  Created by Andrei Ionescu on 07/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//

import UIKit

//The controller is this View Controller that updates the view and talks/listens to the model
//The view is inside interface builder
class MVCViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var model: MVCModelForHangman!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "MVC"
        
        self.model = MVCModelForHangman()
        self.textField.delegate = self
        
        //Update View for first time
        self.wordLabel.text = self.model.theTrimmedWord!
        self.imageView.image = UIImage.init(named: "hang" + String(self.model.iteration))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Delegate Functions for text view
    
    //Allow only one character
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 1
    }
    
    //Check answer after enter was tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        textField.resignFirstResponder()

        if self.textField.text == "" {
            self.tipLabel.text = "Enter a character!"
        } else {
        
            switch model.isCharacterGuessedCorrect(character: (self.textField.text?.first)!) {
            case .GameOver:
                self.tipLabel.text = "Game over! Go back and come back here to play again!"
                self.imageView.image = UIImage.init(named: "hang" + String(self.model.iteration))
                self.textField.alpha = 0.0
                
            case .Guessed:
                self.tipLabel.text = "You gussed correctly!"
                self.wordLabel.text = self.model.theTrimmedWord!
                
            case .Failed:
                self.tipLabel.text = "Oh no! Try again! Be careful!"
                self.imageView.image = UIImage.init(named: "hang" + String(self.model.iteration))
                
            case .GameWon:
                self.tipLabel.text = "You won! Congrats! Go back and come back here to play again!"
                self.wordLabel.text = self.model.theTrimmedWord!
                self.textField.alpha = 0.0
            }
            
        }

        self.textField.text = ""
        
        return false
    }

}

//This is the model
class MVCModelForHangman: NSObject {
    
    enum Progress {
        case GameOver
        case GameWon
        case Failed
        case Guessed
    }
    
    var theWord: String!
    var theTrimmedWord: String!
    var iteration: Int!
    var theWordArray: [Character]!
    var isAtCharacter: Int!

    override init() {
        super.init()
        self.theWord = self.getRandomWord()
        self.theWordArray = Array(self.theWord)
        self.isAtCharacter = 1
        self.theTrimmedWord = self.getTrimmedWord(startingIndex: self.isAtCharacter)
        self.iteration = 0
    }
    
    func getRandomWord() -> String {
        var words = [String]()
        words.append("Swift")
        words.append("Manchester")
        words.append("Iasi")
        words.append("Hamburger")
        words.append("Developer")

        let randomIndex = Int(arc4random_uniform(UInt32(words.count)))
        return words[randomIndex]
    }
    
    //transform the word from IASI to I _ _ I
    func getTrimmedWord(startingIndex: Int) -> String {
        var theTrimedWordArray: Array! = self.theWordArray
        var index = startingIndex
        var count = self.theWordArray.count - 1
       while index < count {
            theTrimedWordArray.insert(" ", at: index)
            theTrimedWordArray[index + 1] = "_"
            index = index + 2
            count = count + 1
            print(theTrimedWordArray)
        }
        return String(theTrimedWordArray)
    }
    
    //Check if character was guessed
    func isCharacterGuessedCorrect(character: Character) -> Progress {
        if character != self.theWordArray[isAtCharacter] && self.iteration >= 5 {
            self.iteration = self.iteration + 1
            return .GameOver
        } else if character == self.theWordArray[isAtCharacter] && self.isAtCharacter == self.theWordArray.count - 2 {
            self.isAtCharacter = self.isAtCharacter + 1
            self.theTrimmedWord = self.getTrimmedWord(startingIndex: self.isAtCharacter)
            return .GameWon
        } else if character == self.theWordArray[isAtCharacter]{
            self.isAtCharacter = self.isAtCharacter + 1
            self.theTrimmedWord = self.getTrimmedWord(startingIndex: self.isAtCharacter)
            return .Guessed
        } else {
            self.iteration = self.iteration + 1
            return .Failed
        }
    }
    
}

