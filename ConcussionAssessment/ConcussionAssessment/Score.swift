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
    @NSManaged var scoreID:  String?
    
    @NSManaged var scoreType: String? 
    
    @NSManaged var numSymptoms: NSNumber?     // 22
    @NSManaged var severity: NSNumber?        // 132
    @NSManaged var orientation: NSNumber?     // 5
    @NSManaged var immediateMemory: NSNumber? // 15
    @NSManaged var concentration: NSNumber?   // 5
    @NSManaged var delayedRecall: NSNumber?   // 5
    
    //Standarized Assessment of Concussion
    //SAC: orientation + immediateMemory + concentration + delayed Recall
    @NSManaged var SACTotal: NSNumber?        // 30
    @NSManaged var maddocks: NSNumber?        // 5
    @NSManaged var glasgow: NSNumber?         // 15
    @NSManaged var date: NSDate?
    @NSManaged var balance: NSNumber?
    
    @NSManaged var baselineScore: String?
    
    @NSManaged var flexion: String?
    @NSManaged var extension_: String?
    @NSManaged var rRotation: String?
    @NSManaged var lRotation: String?
    @NSManaged var rLateralFlex: String?
    @NSManaged var lLateralFlex: String?
    
    @NSManaged var rParaspinalTenderness: String?
    @NSManaged var lParaspinalTenderness: String?
    @NSManaged var bonyTenderness: String?

    @NSManaged var rUpSensation: String?
    @NSManaged var lUpSensation: String?
    
    @NSManaged var rUpStrength: String?
    @NSManaged var lUpStrength: String?
    
    @NSManaged var rLowSensation: String?
    @NSManaged var lLowSensation: String?
    
    @NSManaged var rLowStrength: String?
    @NSManaged var lLowStrength: String?
    
}

