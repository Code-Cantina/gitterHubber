//
//  UIHelper.swift
//  GitHubFol
//
//  Created by Danny Copeland on 4/27/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//

import UIKit

enum UIHelper {
    
    //the view controller does not care about this, so I moved it out to a helper
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
