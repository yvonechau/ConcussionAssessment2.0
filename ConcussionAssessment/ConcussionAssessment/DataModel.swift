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
//    override init()
//    {
//        super.init()
//        // This resource is the same name as your xcdatamodeld contained in your project.
//        guard let modelURL = NSBundle.mainBundle().URLForResource("DataModel", withExtension:"momd")
//        else {
//            fatalError("Error loading model from bundle")
//        }
//        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else
//        {
//            fatalError("Error initializing mom from: \(modelURL)")
//        }
//        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
//        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
//        self.managedObjectContext.persistentStoreCoordinator = psc
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
//        {
//            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
//            let docURL = urls[urls.endIndex-1]
//            /* The directory the application uses to store the Core Data store file.
//             This code uses a file named "DataModel.sqlite" in the application's documents directory.
//             */
//            let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")
//            do
//            {
//                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
//            }
//            catch
//            {
//                fatalError("Error migrating store: \(error)")
//            }
//        }
//    }
    
    init (persistentStoreCoordinator : NSPersistentStoreCoordinator, managedObjectContext : NSManagedObjectContext) {
        self.persistentStoreCoordinator = persistentStoreCoordinator
        self.managedObjectContext = managedObjectContext
    }
    
    // create a Player Object and save it
    func insertNewPlayer(playerID: String, firstName: String, lastName: String, birthday: NSDate, gender: String) {
        let player = NSEntityDescription.insertNewObjectForEntityForName("Player", inManagedObjectContext: managedObjectContext) as! Player
        player.playerID  = playerID
        player.firstName = firstName
        player.lastName  = lastName
        //player.teamName  = teamName
        player.birthday  = birthday
        player.gender    = gender
        player.dateCreated = NSDate()
        
        //player.playerID  = playerID
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Player Object")
        }
    }
    
    // create a Score Object and save it
    func insertNewScore(playerID: String, scoreID: String) {
        let score = NSEntityDescription.insertNewObjectForEntityForName("Score", inManagedObjectContext: managedObjectContext) as! Score
        //score.playerID = playerID
        //score.scoreID  = NSUUID().UUIDString
        score.date     = NSDate()
        score.scoreID  = scoreID
        score.playerID = playerID
        
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
        
    }
    
    func insertNewScoreNoPlayer(scoreID: String) {
        let score = NSEntityDescription.insertNewObjectForEntityForName("Score", inManagedObjectContext: managedObjectContext) as! Score
        //score.playerID = playerID
        //score.scoreID  = NSUUID().UUIDString
        score.date     = NSDate()
        score.scoreID  = scoreID
        
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
        
    }

// This function probably is not needed because core data does not use unique id keys
    
//    func insertNewScoreWithoutPlayer(scoreID: String){
//        let score = NSEntityDescription.insertNewObjectForEntityForName("Score", inManagedObjectContext: managedObjectContext) as! Score
//        score.playerID = "-1"
//        score.date     = NSDate()
//        score.scoreID  = scoreID
//        
//        do {
//            try self.managedObjectContext.save()
//        } catch {
//            fatalError("Cannot create Score Object with playerID")
//        }
//    }
    
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
    
    // Get all Player Objects that exist
    func players(name: String) -> [Player] {
        let fetchRequest = NSFetchRequest(entityName: "Player");

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
//            for e in fetchedScores {
//                NSLog(e.playerID + " " + e.SACTotal!.stringValue)
//            }
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

    func setNumSymptoms(id: String, score: NSNumber) {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        var fetchScore: [Score]
        
        do {
            fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
        } catch {
            fatalError("Failed to get Score")
        }
        fetchScore[0].numSymptoms = score;
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
    
    func setSeverity(id: String, score: NSNumber) {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        var fetchScore: [Score]
        
        do {
            fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
        } catch {
            fatalError("Failed to get Score")
        }
        fetchScore[0].severity = score;
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
    
    func setOrientation(id: String, score: NSNumber) {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        var fetchScore: [Score]
        
        do {
            fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
        } catch {
            fatalError("Failed to get Score")
        }
        fetchScore[0].orientation = score;
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
    
    func setImmMemory(id: String, score: NSNumber) {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        var fetchScore: [Score]
        
        do {
            fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
        } catch {
            fatalError("Failed to get Score")
        }
        fetchScore[0].immediateMemory = score;
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
    
    func setConcentration(id: String, score: NSNumber) {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        var fetchScore: [Score]
        
        do {
            fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
        } catch {
            fatalError("Failed to get Score")
        }
        fetchScore[0].concentration = score;
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
    
    func setDelayedRecall(id: String, score: NSNumber) {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        var fetchScore: [Score]
        
        do {
            fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
        } catch {
            fatalError("Failed to get Score")
        }
        fetchScore[0].delayedRecall = score;
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
    
    func setSACTotal(id: String, score: NSNumber) {
        
    }
    
    func setMaddocks(id: String, score: NSNumber) {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        var fetchScore: [Score]
        
        do {
            fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
        } catch {
            fatalError("Failed to get Score")
        }
        fetchScore[0].maddocks = score;
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
    
    func setGlasgow(id: String, score: NSNumber) {
        let fetchRequest = NSFetchRequest(entityName: "Score");
        fetchRequest.predicate = NSPredicate(format: "scoreID == %@", id);
        var fetchScore: [Score]
        
        do {
            fetchScore = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Score]
        } catch {
            fatalError("Failed to get Score")
        }
        fetchScore[0].glasgow = score;
        
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Cannot create Score Object with playerID")
        }
    }
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