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
    static func saveObjectToRealm(recentFact: RecentFact) {
        let realm = Realm()
        realm.write() {
            realm.add(recentFact)
        }
    }
    
    static func doesRealmHaveRecentFacts(recentDatesAsInts: [Int], recentFactsFromRealm: [RecentFact]) -> Bool {
        var areRecentFactsOnRealm: Bool
        let realm = Realm()
        var realmQueryArray = [Int]()
        if recentFactsFromRealm != [] {
            for var i:Int = 0; i<7; i++ {
                var realmQuery = realm.objects(RecentFact).filter("forDate == %d", recentFactsFromRealm[i].forDate)
                realmQueryArray.append(recentFactsFromRealm[i].forDate)
            }
            areRecentFactsOnRealm = true
        }
        else {
            areRecentFactsOnRealm = false
        }
        
        return areRecentFactsOnRealm
    }
    
    static func displayFactFromRealm(recentDatesAsInts: [Int], var recentFactsFromRealm: [RecentFact]) -> Void {
        println("Recent Facts On Realm: \(recentFactsFromRealm.count)")
        let realm = Realm()
        for var i=0; i<7; i++ {
            var realmQuery = realm.objects(RecentFact).filter("forDate == %d", recentDatesAsInts[i])
            recentFactsFromRealm[i] = realmQuery.first!
        }
        
    }
}
