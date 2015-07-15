//
//  RecentFactsTableViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/13/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit
import Parse
import RealmSwift

class RecentFactsTableViewController: UIViewController {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var fact: [Fact] = []
    var detailOfFact: String = "Uh Oh...Could not find more information for this fact :("
    var forDate: Int = 0
    var contentOfFact: String = "No fact"
    var sourceName: String = ""
    var sourceUrl: String = "https://www.google.com"
    var recentFacts: [Fact] = []
    
    let dateHelper = DateHelper()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Display Recent Facts
        displayRecentFacts(dateHelper.dateTodayAsInt())
    }
    
    func displayRecentFacts(dateTodayAsInt: Int) {
        //Reset Recent Facts Array
        recentFacts = []
        
        //Determine Past 7 days
        var recentDatesAsInts: [Int] = dateHelper.recentDays()
        
        //Query Parse
        let query = PFQuery(className: "Fact")
        query.orderByDescending("forDate")
        query.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.fact = result as? [Fact] ?? []
            
            //Loop through fact array
            for fact in self.fact {
                //Retrieve info of each PFObject
                self.forDate = fact.forDate
                self.contentOfFact = fact.contentOfFact
                self.detailOfFact = fact.detailOfFact
                
                //Loop through recentDatesAsInts
                for var i = 0; i<recentDatesAsInts.count; i++ {
                    if fact.forDate == recentDatesAsInts[i] {
                        self.recentFacts.append(fact)
                    }
                }
            }
            
            self.tableView.reloadData()

        }
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showOldDetail" {
            var destViewController = segue.destinationViewController as! MoreInfoViewController
            destViewController.factDetailLabelText = detailOfFact
            destViewController.source = sourceName
            destViewController.sourceUrl = sourceUrl
            println(sourceName)
        }
    }
    

}

extension RecentFactsTableViewController: UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Int(recentFacts?.count ?? 0)
        return Int(recentFacts.count ?? 0)
        //return 7
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recentFactCell", forIndexPath: indexPath) as! RecentFactTableViewCell
    
        // Configure the cell...
        let row = indexPath.row
        let recentFact = self.recentFacts[row] as Fact
        cell.contentOfFact.text = recentFact.contentOfFact
        cell.forDate.text = "\(recentFact.forDate)"
        
        return cell
    }
    

}

extension RecentFactsTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Do Something
        detailOfFact = recentFacts[indexPath.row].detailOfFact
        sourceName = recentFacts[indexPath.row].sourceName
        sourceUrl = recentFacts[indexPath.row].sourceUrl
        performSegueWithIdentifier("showOldDetail", sender: self)
    }
}
