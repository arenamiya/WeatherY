//
//  Temperature.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 9/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation

struct CustomTime {
    
    var dt : Double
    
    init(dt: Double) {
        self.dt = dt
    }
    
    func UTCToLocal() -> String {
        let date = CustomDate(dt: dt).date
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let time = formatter.string(from: date)
        return time
    }
    
}
