//
//  NumberTestViewController.swift
//  Concussion App 2.0
//
//  Created by Philson Wong on 2/16/16.
//  Copyright © 2016 Kevin Fu. All rights reserved.
//

import UIKit

class NumberTestViewController: UIViewController {
    @IBAction func saveAndDonePressed(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("CognitiveTableViewController")
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Number Test"
        // Do any additional setup after loading the view, typically from a nib.
    }
}
