//
//  ProfileCollectionViewLayout.swift
//  ConcussionAssessment
//
//  Created by Philson Wong on 4/25/16.
//  Copyright © 2016 PYKS. All rights reserved.
//

import UIKit

class ProfileCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attr = super.layoutAttributesForElementsInRect(rect)!
        for i in 1 ..< attr.count {
            let currentLayoutAttributes: UICollectionViewLayoutAttributes = attr[i] 
            let prevLayoutAttributes: UICollectionViewLayoutAttributes = attr[i - 1]
            let maximumSpacing: CGFloat = 5
            let originX: CGFloat = CGRectGetMaxX(prevLayoutAttributes.frame)
            let originY: CGFloat = CGRectGetMaxY(prevLayoutAttributes.frame)
            if originX + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize().width {
                var frame: CGRect = currentLayoutAttributes.frame
                frame.origin.x = originX + maximumSpacing
                currentLayoutAttributes.frame = frame
            }
            if originY + maximumSpacing + currentLayoutAttributes.frame.size.height < self.collectionViewContentSize().height {
                var frame: CGRect = currentLayoutAttributes.frame
                frame.origin.y = originY + maximumSpacing
                currentLayoutAttributes.frame = frame
            }
        }
        return attr
    }
}
