//
//  UITableView+Ext.swift
//  GitHubFol
//
//  Created by Danny Copeland on 7/27/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    //optional handy extension. Only use if only doing this one thing on thread
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}
