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
    var sourceName: String = "No Source"
    var sourceUrl: String = "https://www.google.com"
    var recentFactsFromParse: [Fact] = []
    var recentFactsFromRealm: [RecentFact] = []
    var fetchFromParse: Bool = true


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        var recentDatesAsInts = DateHelper.recentDays()
        
        var realmHasRecentFacts = RealmHelper.doesRealmHaveRecentFacts(recentDatesAsInts, recentFactsFromRealm: recentFactsFromRealm)
        
        //LoadingOverlay.shared.showOverlay(self.view)
        if realmHasRecentFacts {
            //display fact through Realm
            println("Accessing Recent Facts From Realm")
            fetchFromParse = false
            RealmHelper.displayFactFromRealm(recentDatesAsInts, recentFactsFromRealm: recentFactsFromRealm)
            tableView.reloadData()
        }
        else {
            //display fact through Parse
            println("Accessing Recent Facts From Parse")
            fetchFromParse = true
            displayRecentFactsFromParse(recentDatesAsInts)
            tableView.reloadData()
        }
        //LoadingOverlay.shared.hideOverlayView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayRecentFactsFromParse(recentDatesAsInts: [Int]) {
        //Query Parse
        ParseHelper.queryForRecentFacts {(result: [AnyObject]?, error: NSError?) -> Void in
            self.fact = result as? [Fact] ?? []
            
            //Loop through fact array
            for fact in self.fact {
                //Retrieve info of each PFObject
                
                self.forDate = fact.forDate
                self.contentOfFact = fact.contentOfFact
                self.detailOfFact = fact.detailOfFact
                
                
                //Loop through recentDatesAsInts
                //var i = find(self.fact, fact)!
                for var i = 0; i<recentDatesAsInts.count; i++ {
                    if fact.forDate == recentDatesAsInts[i] {
                        //Add info to Parse array
                        self.recentFactsFromParse.append(fact)
                        
                        //Store Properties into a realm variable
                        var newRealmFact = RecentFact()
                        newRealmFact.forDate = self.forDate
                        newRealmFact.contentOfFact = self.contentOfFact
                        newRealmFact.detailOfFact = self.detailOfFact
                        newRealmFact.sourceName = self.sourceName
                        newRealmFact.sourceUrl = self.sourceUrl
                        
                        //Add information to realm array
                        self.recentFactsFromRealm.append(newRealmFact)
                        
                        //Save recentFactsFromRealm To Realm
                        RealmHelper.saveObjectToRealm(self.recentFactsFromRealm.last!)
                        
                        //Stop the for loop
                        i+=recentDatesAsInts.count

                    }
                }
                
                
            }
            
            self.tableView.reloadData()
            //println(self.recentFacts.count)

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
        
        return recentFactsFromParse.count ?? 0
        
        //return 7
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recentFactCell", forIndexPath: indexPath) as! RecentFactTableViewCell
    
        // Configure the cell...
        let row = indexPath.row
        
        if fetchFromParse {
            let recentFact = self.recentFactsFromParse[row] as Fact
            
            cell.contentOfFact.text = recentFact.contentOfFact
            cell.forDate.text = DateHelper.formatForDate(recentFact.forDate)
        }
        else {
            let recentFactFromRealm = self.recentFactsFromRealm[row] as RecentFact
            //println(recentFactFromRealm.contentOfFact)
            cell.contentOfFact.text = recentFactFromRealm.contentOfFact
            cell.forDate.text = DateHelper.formatForDate(recentFactFromRealm.forDate)
        }
        
        return cell
    }
    

}

extension RecentFactsTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Do Something
        if fetchFromParse {
            detailOfFact = recentFactsFromParse[indexPath.row].detailOfFact
            sourceName = recentFactsFromParse[indexPath.row].sourceName
            sourceUrl = recentFactsFromParse[indexPath.row].sourceUrl
        }
        else
        {
            detailOfFact = recentFactsFromRealm[indexPath.row].detailOfFact
            sourceName = recentFactsFromRealm[indexPath.row].sourceName
            sourceUrl = recentFactsFromRealm[indexPath.row].sourceUrl
        }
        performSegueWithIdentifier("showOldDetail", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        /*fact = []
        recentFactsFromParse = []
        recentFactsFromRealm = []*/
    }
}
