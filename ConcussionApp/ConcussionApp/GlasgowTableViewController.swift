//
//  GlasgowTableViewController.swift
//  Concussion App 2.0
//
//  Created by Yvone Chau on 2/16/16.
//  Copyright © 2016 Kevin Fu. All rights reserved.
//

import UIKit

class GlasgowTableViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.navigationItem.title = "Glasgow"
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .Plain, target: self.navigationController!, action: "popViewControllerAnimated:")
    }
    
    var data = ["No eye opening", "Eye opening in response to pain", "Eye opening to speech", "Eyes opening spontaneously" ]
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EyeCell", forIndexPath: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("glasgowVerbalTableViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}