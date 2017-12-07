//
//  FactoryViewController.swift
//  SwiftDesignPatterns
//
//  Created by Andrei Ionescu on 07/12/2017.
//  Copyright © 2017 Andrei Ionescu. All rights reserved.
//


//HOW THIS WORKS:
//You want to send different congrats to different people. You have acquaintances, friends and family. We need to send the greeting without caring too much about the person's category.
//Please find factory classes below

import UIKit

class FactoryViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var congratsLabel: UILabel!
    var personFelicitationsArray = [PersonFelicitations]()

    override func viewDidLoad() {
        super.viewDidLoad()

        personFelicitationsArray.append(PersonFelicitations(name: "Ema", age: 25, relationshipStatus: .Acquaintance))
        personFelicitationsArray.append(PersonFelicitations(name: "Max", age: 20, relationshipStatus: .Friend))
        personFelicitationsArray.append(PersonFelicitations(name: "Grandma", age: 77, relationshipStatus: .Family))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender:UISegmentedControl) {
        
        let client = PersonFelicitationsFactory.getPersonToCongratulate(felicitations: personFelicitationsArray[segmentedControl.selectedSegmentIndex])
        self.congratsLabel.text = client.sendBdayCongrats()

    }
    

}

//All classes needed for FACTORY can be found below

//Protocol that all Objects have to adhere to
protocol PersonBdayHonoreeProtocol {
    func sendBdayCongrats()->String
}

//The object found in each person category object
class PersonFelicitations: NSObject {
    var name: String!
    var age: Int!
    var relationshipStatus: RelationshipStatus!
    
    enum RelationshipStatus {
        case Acquaintance
        case Friend
        case Family
    }
    
    init(name: String, age: Int, relationshipStatus: RelationshipStatus) {
        self.name = name
        self.age = age
        self.relationshipStatus = relationshipStatus
    }
}

class AcquaintanceBdayHonoree: PersonBdayHonoreeProtocol {
    
    var felicitations: PersonFelicitations!
    
    init(felicitations: PersonFelicitations) {
        self.felicitations = felicitations
    }
    
    func sendBdayCongrats() -> String {
        return "Dear \(felicitations.name!), I wish you a happy birthday and wish you all the best. I hope that you will have an amazing \(felicitations.age!) birthday party!"
    }
}

class FriendBdayHonoree: PersonBdayHonoreeProtocol {
    
    var felicitations: PersonFelicitations!
    
    init(felicitations: PersonFelicitations) {
        self.felicitations = felicitations
    }
    
    func sendBdayCongrats() -> String {
        return "Hey \(felicitations.name!). Wow! You're \(felicitations.age!) now! I wish you happy bday and we should talk and meet asap."
    }
}

class FamilyBdayHonoree: PersonBdayHonoreeProtocol {
    
    var felicitations: PersonFelicitations!
    
    init(felicitations: PersonFelicitations) {
        self.felicitations = felicitations
    }
    
    func sendBdayCongrats() -> String {
        return "\(felicitations.name!)! You're \(felicitations.age!)! Please let's meet soon for dinner. I bought you a nice present!"
    }
}


class PersonFelicitationsFactory {
    static func getPersonToCongratulate(felicitations: PersonFelicitations)->PersonBdayHonoreeProtocol {
        switch felicitations.relationshipStatus {
        case .Acquaintance:
            return AcquaintanceBdayHonoree(felicitations: felicitations)
        case .Friend:
            return FriendBdayHonoree(felicitations: felicitations)
        case .Family:
            return FamilyBdayHonoree(felicitations: felicitations)
        default:
            return AcquaintanceBdayHonoree(felicitations: felicitations) //Despite this switch is exhaustive, I had to add this line of code to silence an error. This should never happen
        }
    }
}


