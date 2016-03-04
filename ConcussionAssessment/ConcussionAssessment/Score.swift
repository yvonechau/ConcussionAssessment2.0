//
//  Score.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/29/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import CoreData

class Score : NSManagedObject {
    // Define relationship with Player? 
    // Player -HAS A- Score
    @NSManaged var playerID: String?
    
    @NSManaged var numSymptoms: NSNumber?     // 22
    @NSManaged var severity: NSNumber?        // 132
    @NSManaged var orientation: NSNumber?     // 5
    @NSManaged var immediateMemory: NSNumber? // 15
    @NSManaged var concentration: NSNumber?   // 5
    @NSManaged var delayedRecall: NSNumber?   // 5
    @NSManaged var SACTotal: NSNumber?        // 184
    @NSManaged var maddocks: NSNumber?        // 5
    @NSManaged var glasgow: NSNumber?         // 15
    @NSManaged var date: NSDate?
}

