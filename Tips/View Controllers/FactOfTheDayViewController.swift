//
//  FactOfTheDayViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/11/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit
import Parse

class FactOfTheDayViewController: UIViewController {
    @IBOutlet weak var factOfTheDay: UILabel!
    
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
        //println(dateTodayAsInt)
        displayFactOfTheDay(dateTodayAsInt)
        
    }
    
    func displayFactOfTheDay(dateTodayAsInt: Int) -> Void {
        
        //Query Parse
        //let query = Fact.query()
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
                    //var index = find(self.fact, fact)
                    println(contentOfFact)
                    self.factOfTheDay.text = contentOfFact
                    //contentForToday = self.fact[index!].contentOfFact
                    //contentForToday = fact.contentOfFact
                }
            }
            //println(self.fact.count)
            //println(self.fact[0].contentOfFact)
            /*for (var i=0; i<self.fact.count; i++) {
            
            }*/
            
            
            //Set factOfTheDay Label to be equal to the contentOfFact
            //self.fact[0].factLabel!.text = contentForToday
            //self.factOfTheDay.text = contentForToday
            //println(contentForToday)
            
        }
        
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
