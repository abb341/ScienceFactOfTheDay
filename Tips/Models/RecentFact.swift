//
//  RecentFact.swift
//  Tips
//
//  Created by Aaron Brown on 7/13/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import Foundation
import Parse
import RealmSwift

class RecentFact: Object {
    dynamic var contentOfNote: String = ""
    dynamic var forDate: Int = 0
}
