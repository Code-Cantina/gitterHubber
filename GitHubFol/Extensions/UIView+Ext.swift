//
//  UIView+Ext.swift
//  GitHubFol
//
//  Created by Danny Copeland on 7/27/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) { //variactic parameter
        for view in views { addSubview(view) }
    }
}
