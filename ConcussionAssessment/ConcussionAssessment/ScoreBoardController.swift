//
//  ScoreBoardController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/24/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import UIKit

class ScoreBoardController : UIViewController
{

    var y_pos: CGFloat = 0;
    var original : UIViewController?
    
    init(originalPage: UIViewController)
    {
        self.original = originalPage
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func doneButtonPressed(sender: UIButton)
    {
        self.navigationController?.popToViewController(self.original!, animated: true)
    }
    
    override func viewDidLoad() {
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(TablePageView.doneButtonPressed(_:)))
      
        self.navigationItem.rightBarButtonItems = [doneButton]
        
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let (scoreTitle, scoreResults, neckExam) = database.scoreStringArray(currentScoreID!)

        
        for index in 0...7
        {
            let title = UILabel(frame: CGRect(x: 20, y: y_pos, width: view.frame.width, height: 200))
            title.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            title.textAlignment = .Left
            title.text = scoreTitle[index]
            self.view.addSubview(title)
            
            let score = UILabel(frame: CGRect(x: -20, y: y_pos, width: view.frame.width, height: 200))
            score.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            score.textAlignment = .Right
            score.text = scoreResults[index]

            self.view.addSubview(score)
            
            y_pos = y_pos + 30
        }
        
        let title = UILabel(frame: CGRect(x: 20, y: y_pos, width: view.frame.width, height: 200))
        title.textColor = UIColor.blackColor()
        //label.center = CGPointMake(160, 284)
        title.textAlignment = .Left
        title.text = "Neck Examination Notes"
        self.view.addSubview(title)
        
        y_pos = y_pos + 30
        
        
        for index in 0 ... 16
        {
            let title = UILabel(frame: CGRect(x: 20, y: y_pos, width: view.frame.width, height: 200))
            title.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            title.textAlignment = .Left
            title.text = neckExam[index][0]
            self.view.addSubview(title)
            
            let score = UILabel(frame: CGRect(x: -20, y: y_pos, width: view.frame.width, height: 200))
            score.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            score.textAlignment = .Right
            score.text = neckExam[index][1]
            
            self.view.addSubview(score)
            
            y_pos = y_pos + 30
        }
        
    }
}