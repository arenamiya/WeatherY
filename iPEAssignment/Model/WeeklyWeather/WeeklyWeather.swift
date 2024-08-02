//
//  WeeklyWeather.swift
//  iPEAssignment
//
//  Created by Aren Carter on 6/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeeklyWeather {
    
    private var week = [DayWeather]()
    
    init(data : JSON) {
        
        let data = data["daily"]
        
        for day in data{
            week.append(DayWeather(data: day.1))
        }
    }
    
    func getDayFromWeek(index: Int) -> DayWeather {
        return week[index]
    }
    
    func getWeek() -> [DayWeather] {
        return week
    }

}

