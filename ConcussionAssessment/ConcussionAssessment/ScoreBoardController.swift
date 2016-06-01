//
//  ScoreBoardController.swift
//  ConcussionAssessment
//
//  Created by Yvone Chau on 2/24/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import Foundation
import UIKit

class ScoreBoardController : UIViewController, UIScrollViewDelegate
{

    var y_pos: CGFloat = 0;
    var original : UIViewController?
  
    var scrollView: UIScrollView
  var containerView: UIView
  init(originalPage: UIViewController)
    {
        self.original = originalPage
        self.scrollView = UIScrollView()
        self.containerView = UIView()

        super.init(nibName:nil, bundle:nil)
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.bounds.size.height * 2);
        self.scrollView.scrollEnabled = true;
        self.scrollView.showsVerticalScrollIndicator = true;
        self.scrollView.delegate = self
  
  
  
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
  
  
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      
      scrollView.frame = view.bounds
      containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
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
        
        self.scrollView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let (scoreTitle, scoreResults, neckExam) = database.scoreStringArray(currentScoreID!)

        
        for index in 0...7
        {
            let title = UILabel(frame: CGRect(x: 20, y: y_pos, width: view.frame.width, height: 200))
            title.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            title.textAlignment = .Left
            title.text = scoreTitle[index]
            self.containerView.addSubview(title)
            
            let score = UILabel(frame: CGRect(x: -20, y: y_pos, width: view.frame.width, height: 200))
            score.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            score.textAlignment = .Right
            score.text = scoreResults[index]

            self.containerView.addSubview(score)
            
            y_pos = y_pos + 30
        }
        
        let title = UILabel(frame: CGRect(x: 20, y: y_pos, width: view.frame.width, height: 200))
        title.textColor = UIColor.blackColor()
        //label.center = CGPointMake(160, 284)
        title.textAlignment = .Left
        title.text = "Neck Examination Notes"
        self.containerView.addSubview(title)
        
        y_pos = y_pos + 30
        
        
        for index in 0 ... 16
        {
            let title = UILabel(frame: CGRect(x: 20, y: y_pos, width: view.frame.width, height: 200))
            title.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            title.textAlignment = .Left
            title.text = neckExam[index][0]
            self.containerView.addSubview(title)
            
            let score = UILabel(frame: CGRect(x: -20, y: y_pos, width: view.frame.width, height: 200))
            score.textColor = UIColor.blackColor()
            //label.center = CGPointMake(160, 284)
            score.textAlignment = .Right
            score.text = neckExam[index][1]
            
            self.containerView.addSubview(score)
            
            y_pos = y_pos + 30
        }
        
    }
}