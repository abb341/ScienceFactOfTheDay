//
//  RealmHelper.swift
//  Tips
//
//  Created by Aaron Brown on 7/16/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    /*
    static func saveObjectToRealm(recentFact: RecentFact) {
        let realm = Realm()
        realm.write() {
            realm.add(recentFact)
        }
    }*/
    
    /*
    static func doesRealmHaveRecentFacts(recentDatesAsInts: [Int], recentFactsFromRealm: [RecentFact]) -> Bool {
        var areRecentFactsOnRealm: Bool
        let realm = Realm()
        var realmQueryArray = [Int]()
        if recentFactsFromRealm != [] {
            for var i:Int = 0; i<7; i++ {
                var realmQuery = realm.objects(RecentFact).filter("factNumber == %d", recentFactsFromRealm[i].factNumber)
                realmQueryArray.append(recentFactsFromRealm[i].factNumber)
            }
            areRecentFactsOnRealm = true
        }
        else {
            areRecentFactsOnRealm = false
        }
        
        return areRecentFactsOnRealm
    }*/
    
    /*
    static func displayFactFromRealm(recentDatesAsInts: [Int], var recentFactsFromRealm: [RecentFact]) -> Void {
        println("Recent Facts On Realm: \(recentFactsFromRealm.count)")
        let realm = Realm()
        for var i=0; i<7; i++ {
            var realmQuery = realm.objects(RecentFact).filter("forDate == %d", recentDatesAsInts[i])
            recentFactsFromRealm[i] = realmQuery.first!
        }
        
    }
*/
    
    
    /*
    static func removeOldObjectsFromRealm(recentFactNumbers: [Int]) {
        let realm = Realm()
        var realmFactsToKeep: [RecentFact] = []
        for var i = 0; i<recentFactNumbers.count; i++ {
            var realmQuery = realm.objects(RecentFact).filter("factNumber == %d", recentFactNumbers[i])
            if let fact = realmQuery.first {
                realmFactsToKeep.append(realmQuery.first!)
            }
        }
        realm.write() {
            //Delete All Realm Objects
            realm.deleteAll()
            
            //Loop through recentFactsToKeep
            for var i = 0; i<realmFactsToKeep.count; i++ {
                //Add back Facts to Keep
                realm.add(realmFactsToKeep[i])
            }
        }
    }
*/
}
