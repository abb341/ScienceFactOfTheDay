//
//  FactOfTheDayViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/11/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit
import Parse
import RealmSwift

class FactOfTheDayViewController: UIViewController {
    @IBOutlet weak var factOfTheDay: UILabel!
    @IBAction func presentNavigation(sender: AnyObject?){
        performSegueWithIdentifier("presentMenu", sender: self)
    }
    @IBAction func learnMoreButtonPressed(sender: AnyObject){
        performSegueWithIdentifier("learnMore", sender: self)
    }
    
    var fact: [Fact] = []
    var detailOfFact: String = "Sorry, There is no more information for this fact :("
    let dateHelper = DateHelper()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        //Reset Realm Data
        var realm = Realm()
        realm.write() {
            realm.deleteAll()
        } */
        
        
        //Date
        var dateTodayAsInt = dateHelper.dateTodayAsInt()
        var factOnRealm = checkRealmForFOTD(dateTodayAsInt)
        if factOnRealm {
            //display fact through Realm
            println("Accessing Realm")
            displayFactFromRealm(dateTodayAsInt)
        }
        else {
            //display fact through Parse
            println("Accessing Parse")
            displayFactOfTheDay(dateTodayAsInt)
        }
        
    }
    
    // MARK: Fact Of The Day Realm
    
    func displayFactFromRealm(dateTodayAsInt: Int) -> Void {
        let realm = Realm()
        var realmQuery = realm.objects(RecentFact).filter("forDate == %d", dateTodayAsInt)
        var recentFact = realmQuery.first
        self.factOfTheDay.text = recentFact?.contentOfFact
        self.detailOfFact = recentFact!.detailOfFact
    }
    
    func checkRealmForFOTD(dateTodayAsInt: Int) -> Bool {
        var isFOTDOnRealm: Bool
        let realm = Realm()
        var realmQuery = realm.objects(RecentFact).filter("forDate == %d", dateTodayAsInt)
        if realmQuery.count == 0 {
            isFOTDOnRealm = false
        }
        else {
            isFOTDOnRealm = true
        }
        
        return isFOTDOnRealm
    }
    
    // MARK: Fact Of The Day Parse
    func displayFactOfTheDay(dateTodayAsInt: Int) -> Void {
        
        //Query Parse
        let query = PFQuery(className: "Fact")
        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.fact = result as? [Fact] ?? []
            
            //Loop through fact array
            for fact in self.fact {
                //Retrieve info of each PFObject
                var forDate = fact.forDate
                var contentOfFact = fact.contentOfFact
                var detailOfFact = fact.detailOfFact
                
                //Compare forDate to dateTodayAsInt
                if (dateTodayAsInt != forDate) {
                    var index = find(self.fact, fact)
                    self.fact.removeAtIndex(index!)
                    //fact.removeAtIndex(index: indexOf(fact, self.fact))
                }
                else {
                    self.factOfTheDay.text = contentOfFact
                    self.detailOfFact = detailOfFact
                    
                    //Store Fact on Realm
                    var recentFact = RecentFact()
                    recentFact.contentOfFact = contentOfFact
                    recentFact.forDate = forDate
                    recentFact.detailOfFact = detailOfFact
                    let realm = Realm()
                    realm.write() {
                        realm.add(recentFact)
                    }
                }
            }
            
            
            
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "learnMore" {
            var destViewController = segue.destinationViewController as! LearnMoreViewController
            destViewController.factDetailsText = detailOfFact
        }
    }
    
}
