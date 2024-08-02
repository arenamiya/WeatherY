//
//  CustomDate.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 6/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation

struct CustomDate {
    
    private (set) var date: Date
    
    init(dt: Double) {
        date = Utility.unixToDate(dt: dt)
    }
    
    func toString(as format:String = "dd-MM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    /**
    * @return date in "EEEE, MMM d" format
    */
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM d"
        return dateFormatter.string(from: date)
    }

    func time() -> String {
        let date = self.date
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let time = formatter.string(from: date)
        return time
    }
}
