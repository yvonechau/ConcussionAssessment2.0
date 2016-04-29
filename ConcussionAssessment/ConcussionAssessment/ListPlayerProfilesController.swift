//
//  ListPlayerProfilesController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/23/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import UIKit

class ListPlayerProfileController: UITableViewController {
    var player1: UITableViewCell = UITableViewCell()
    var player2: UITableViewCell = UITableViewCell()
    var player3: UITableViewCell = UITableViewCell()
    var doListPlayers: Bool = true
    var listOfPlayers: [Player]
    var typeOfProfilePage: String
    let numberOfSections = 1
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Profiles"
    }
    
    init(style: UITableViewStyle, type: String) {
        listOfPlayers = database.fetchPlayers()
        if listOfPlayers.count <= 0 {
            doListPlayers = false
        }
        self.typeOfProfilePage = type
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if doListPlayers {
            return listOfPlayers.count
        } else {
            return 1
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Return the row for the corresponding section and row
        if doListPlayers == true {
            let fullPlayerName: String = listOfPlayers[indexPath.row].firstName! + " " + listOfPlayers[indexPath.row].lastName!
            let playerID: String = listOfPlayers[indexPath.row].playerID!
            switch(indexPath.section) {
            case 0:
                    let PlayerProfileSelection = PlayerProfileViewController(name: fullPlayerName, playerID: playerID) as PlayerProfileViewController
                    self.navigationController?.pushViewController(PlayerProfileSelection, animated: true)
            default:
                fatalError("Invalid section")
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        if doListPlayers == true {
            switch(indexPath.section) {
            case 0:
                // Lists the name and team for each player in the database
                cell.textLabel?.text = listOfPlayers[indexPath.row].firstName! + " " + listOfPlayers[indexPath.row].lastName!
                cell.detailTextLabel?.text = "Team: " + listOfPlayers[indexPath.row].teamName!
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            default: fatalError("Unknown section")
            }
        } else {
            cell.textLabel?.textAlignment = .Center
            cell.textLabel?.text = "No players created yet!"
        }
        return cell
    }
}

