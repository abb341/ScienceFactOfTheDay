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
    //Outlets
    @IBOutlet weak var factOfTheDay: UILabel!
    
    //Actions
    @IBAction func presentNavigation(sender: AnyObject?){
        performSegueWithIdentifier("presentMenu", sender: self)
    }
    @IBAction func learnMoreButtonPressed(sender: AnyObject){
        performSegueWithIdentifier("learnMore", sender: self)
    }
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let textToShare = "\"" + factOfTheDay.text! + "\""
        
        if let myWebsite = NSURL(string: "https://www.facebook.com/pages/Pocket-Facts/859528520769026")
        {
            let objectsToShare = [textToShare, "\r\n", myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    //Properties
    var fact: [Fact] = []
    var detailOfFact: String = ""
    var factSourceName: String = "No Source"
    var factSourceUrl: String = "https://www.google.com"

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        /*
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notifications on ios8"
        localNotification.alertBody = "Wow it works!!!"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        */
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
        }*/
        
        
        
        
        //Date
        var dateTodayAsInt = DateHelper.dateTodayAsInt()
        var factOnRealm = checkRealmForFOTD(dateTodayAsInt)
        if factOnRealm {
            //display fact through Realm
            println("Accessing Realm")
            displayFactFromRealm(dateTodayAsInt)
        }
        else {
            //Remove old facts
            RealmHelper.removeOldObjectsFromRealm(DateHelper.recentDays())
            //display fact through Parse
            println("Accessing Parse")
            displayFactOfTheDay(dateTodayAsInt)
            
            //If nothing is on parse
            if (factOfTheDay.text == "")
            {
                factOfTheDay.text = ErrorHandler.defaultLabelText
            }
        }
        //removeOldFacts(dateTodayAsInt)
        
    }
    
    
    // MARK: Fact Of The Day Realm
    
    func displayFactFromRealm(dateTodayAsInt: Int) -> Void {
        let realm = Realm()
        var realmQuery = realm.objects(RecentFact).filter("forDate == %d", dateTodayAsInt)
        var recentFact = realmQuery.first
        self.factOfTheDay.text = recentFact?.contentOfFact
        self.detailOfFact = recentFact!.detailOfFact
        self.factSourceName = recentFact!.sourceName
        self.factSourceUrl = recentFact!.sourceUrl
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
                var sourceName = fact.sourceName
                var sourceUrl = fact.sourceUrl
                
                //Compare forDate to dateTodayAsInt
                if (dateTodayAsInt != forDate) {
                    var index = find(self.fact, fact)
                    self.fact.removeAtIndex(index!)
                    //fact.removeAtIndex(index: indexOf(fact, self.fact))
                }
                else {
                    self.factOfTheDay.text = contentOfFact
                    self.detailOfFact = detailOfFact
                    self.factSourceName = sourceName
                    self.factSourceUrl = sourceUrl
                    
                    //Store Fact on Realm
                    var recentFact = RecentFact()
                    recentFact.contentOfFact = contentOfFact
                    recentFact.forDate = forDate
                    recentFact.detailOfFact = detailOfFact
                    recentFact.sourceName = sourceName
                    recentFact.sourceUrl = sourceUrl
                    
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
            destViewController.source = factSourceName
            destViewController.sourceUrl = factSourceUrl
        }
    }
    
}
