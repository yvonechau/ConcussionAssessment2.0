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
        // need to determine the frame / size for each square on the grid; 
        let numberOfColumns = 3
        let innerSpacing: CGFloat = 2
        let squareDims = (self.collectionViewContentSize().width - CGFloat(numberOfColumns + 1) * innerSpacing) / CGFloat(numberOfColumns)
        
        var currentLeftOffset : CGFloat = innerSpacing
        var currentTopOffset : CGFloat = innerSpacing
        for i in 0 ..< attr.count {
            let currentLayoutAttributes: UICollectionViewLayoutAttributes = attr[i]
            
            // update our current origin
            if (currentLayoutAttributes.indexPath.row % numberOfColumns == 0 && currentLayoutAttributes.indexPath.row != 0) {
                currentLeftOffset = innerSpacing
                currentTopOffset = currentTopOffset + innerSpacing + squareDims
            } else if (currentLayoutAttributes.indexPath.row != 0){
                currentLeftOffset = currentLeftOffset + innerSpacing + squareDims
            }
            
            // adjust the size to the new dimensions
            var layoutAttrSize : CGSize = currentLayoutAttributes.size
            layoutAttrSize.height = CGFloat(squareDims)
            layoutAttrSize.width = CGFloat(squareDims)
            currentLayoutAttributes.size = layoutAttrSize
            
            // adjust the frame to the new location
            var frame: CGRect = currentLayoutAttributes.frame
            frame.origin.x = currentLeftOffset
            frame.origin.y = currentTopOffset
            currentLayoutAttributes.frame = frame
        }
        return attr
    }
}
