//
//  Date+Ext.swift
//  GitHubFol
//
//  Created by Danny Copeland on 5/4/20.
//  Copyright © 2020 Danny Copeland. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
