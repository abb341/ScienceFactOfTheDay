//
//  RecentFactsTableViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/13/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit
import RealmSwift

class RecentFactsTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var recentFacts: Results<RecentFact>! {
        didSet {
            // Whenever notes update, update the table view
            tableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let myFact = RecentFact()
        myFact.forDate = 7102015
        myFact.contentOfFact = "This is an old fact"
        let realm = Realm() // 1
            realm.write() { // 2
                realm.deleteAll()
                realm.add(myFact) // 3
            }
        recentFacts = realm.objects(RecentFact)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecentFactsTableViewController: UITableViewDelegate {
    
}

extension RecentFactsTableViewController: UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(recentFacts?.count ?? 0)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recentFactCell", forIndexPath: indexPath) as! RecentFactTableViewCell
    
        // Configure the cell...
        let row = indexPath.row
        let recentFact = recentFacts[row] as RecentFact
        cell.recentFact = recentFact
    
        return cell
    }

    

}
