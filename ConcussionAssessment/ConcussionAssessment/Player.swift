//
//  Player.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/29/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import CoreData

class Player : NSManagedObject {
    @NSManaged var playerID: String?
    
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var teamName: String?
}
