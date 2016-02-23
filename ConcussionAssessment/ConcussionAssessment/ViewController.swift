//
//  ViewController.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 2/18/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

// ROOT VIEW CONTROLLER ??

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.view addSubview:button];
        */
        print("meepmoop");
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("Test Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}