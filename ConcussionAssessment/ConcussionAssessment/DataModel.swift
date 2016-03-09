//
//  DataModel.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/25/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import CoreData

class DataModel : NSObject {
    var managedObjectContext : NSManagedObjectContext
    var persistentStoreCoordinator : NSPersistentStoreCoordinator
    
    // initialize the database
    init (persistentStoreCoordinator : NSPersistentStoreCoordinator, managedObjectContext : NSManagedObjectContext) {
        self.persistentStoreCoordinator = persistentStoreCoordinator
        self.managedObjectContext = managedObjectContext
    }
    
    // create a Player Object and save it
    func insertNewPlayer(firstName: String, lastName: String, teamName: String, playerID: String) {
        let player = NSEntityDescription.insertNewObjectForEntityForName("Player", inManagedObjectContext: managedObjectContext) as! Player
        player.firstName = firstName
        player.lastName  = lastName
        player.teamName  = teamName
        player.playerID  = playerID
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Player Object")
        }
    }
    
    // create a Score Object and save it
    func insertNewScore(playerID: String, scoreID: String) {
        let score = NSEntityDescription.insertNewObjectForEntityForName("Score", inManagedObjectContext: managedObjectContext) as! Score
        score.playerID = playerID
        score.date     = NSDate()
        score.scoreID  = NSUUID().UUIDString
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
        
    }
    
    func insertNewScoreWithoutPlayer(scoreID: String){
        let score = NSEntityDescription.insertNewObjectForEntityForName("Score", inManagedObjectContext: managedObjectContext) as! Score
        score.playerID = "-1"
        score.date     = NSDate()
        score.scoreID  = scoreID
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
    
    /*
    // assumes global Score Object
    func saveCurrentScore() {
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with Score Object")
        }
    }*/
    
    
    // Get the Player object with specific name
    func playerWithName(name: String) -> [Player] {
        let fetchRequest = NSFetchRequest(entityName: "Player");
        fetchRequest.predicate = NSPredicate(format: "firstName == %@", name);
        
        do {
            let fetchedPlayers = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Player]
            for e in fetchedPlayers {
                NSLog(e.firstName! + " " + e.lastName!)
            }
            return fetchedPlayers
        } catch {
            fatalError("Failed to fetch players")
        }
        
        return []
    }
    
    
    // Get the Score object with specific Player
    func scoresOfPlayer(id: String) -> [Score] {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "playerID == %@", id);
        
        do {
            let fetchedScores = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
            for e in fetchedScores {
                NSLog(e.playerID! + " " + e.SACTotal!.stringValue)
            }
            return fetchedScores
        } catch {
            fatalError("Failed to fetch Scores")
        }
        
        return []
    }
    
    // Get the Score object with specific ScoreID
    func scoreWithID(id: String) -> [Score] {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        
        do {
            let fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
            return fetchScore
        } catch {
            fatalError("Failed to get Score")
        }
        
        return []
    }
    // unique key for player, data want to set 
    //
    
    /*
    // create an Score Object and save it
    func insertNewScore() {
        NSEntityDescription.insertNewObjectForEntityForName("Score", inManagedObjectContext: managedObjectContext) as! Score
        
        my_score.score
        do {
            try self.managedObjectContext.save()
        } catch {
            // error handling
        }
    }
    */
    
    
    /*
    
    // Get the employee(s) with a specific name
    func employeeWithName(name: String) -> [Employee] {
        let fetchRequest = NSFetchRequest(entityName: "Employee");
        fetchRequest.predicate = NSPredicate(format: "firstName == %@", name);
        
        do {
            let fetchedEmployees = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Employee]
            for e in fetchedEmployees {
                NSLog(e.firstName! + " " + e.lastName! + " at " + e.location!)
            }
            return fetchedEmployees
        } catch {
            fatalError("Failed to fetch employees")
        }
        
        return []
    }
*/
    
    // Get the number of players
    func numberOfPlayersInDatabase() -> Int {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        do {
            let fetchedPlayer = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Player]
            return fetchedPlayer.count
        } catch {
            fatalError("Failed to fetch players")
        }
        return 0;
    }
}