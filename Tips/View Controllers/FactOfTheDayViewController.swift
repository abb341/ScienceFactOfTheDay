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
        
        //Date
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.component(.CalendarUnitMonth, fromDate: NSDate())
        let day = calendar.component(.CalendarUnitDay, fromDate: NSDate())
        let year = calendar.component(.CalendarUnitYear, fromDate: NSDate())
        var dateTodayAsInt = month*1000000 + day*10000 + year
        displayFactOfTheDay(dateTodayAsInt)
        
    }
    
    func displayFactOfTheDay(dateTodayAsInt: Int) -> Void {
        
        //Query Parse
        let query = PFQuery(className: "Fact")
        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.fact = result as? [Fact] ?? []
            
            //Loop through fact array
            //var contentForToday = String()
            for fact in self.fact {
                //Retrieve forDate of each PFObject
                var forDate = fact.forDate
                var contentOfFact = fact.contentOfFact
                
                //Compare forDate to dateTodayAsInt
                if (dateTodayAsInt != forDate) {
                    var index = find(self.fact, fact)
                    self.fact.removeAtIndex(index!)
                    //fact.removeAtIndex(index: indexOf(fact, self.fact))
                }
                else {
                    self.factOfTheDay.text = contentOfFact
                    //Save to Realm
                    let realm = Realm()
                    //realm.write {
                      //  realm.add(fact)
                    //}
                }
            }
            
            
            
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
}
