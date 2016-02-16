//
//  DataViewController.swift
//  Concussion App 2.0
//
//  Created by Kevin Fu on 2/14/16.
//  Copyright © 2016 Kevin Fu. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""

    @IBOutlet weak var glasgowButton: UIButton!
    
    @IBAction func symptomPressed(sender: AnyObject)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("symptomViewController")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func glasgowPressed(sender: AnyObject)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("glasgowViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel?.text = dataObject
    }


}

