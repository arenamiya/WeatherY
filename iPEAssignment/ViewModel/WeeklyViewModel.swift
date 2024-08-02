//
//  WeeklyViewModel.swift
//  iPEAssignment
//
//  Created by Aren Carter on 23/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit
import SwiftyJSON 

struct WeeklyViewModel {
    
    private var ww : WeeklyWeather?
    
    init() {
        if let data : JSON = Utility.readJsonFile(fileName: "OneCall") {
            ww = WeeklyWeather(data: data)
        }
    }
    
    
    func getFormattedWeeklyWeather() -> ([(date: String, min: String, max: String, weatherIcon : UIImage?, rain: String)]) {
        var weeklyWeather = [(String, String, String, UIImage?, String)]()
        guard let wwM = ww else { return([("", "", "", nil, "")]) }
        
        for day in wwM.getWeek() {
            let date = day.getDate().dateString()
            let min = Utility.getTempString(temp: day.getTemp(type: .min))
            let max = Utility.getTempString(temp: day.getTemp(type: .max))
            let weatherIcon = UIImage(named: "test")
            let rain = String(day.getPrecipitation()) + "mm"
            weeklyWeather.append((date, min, max, weatherIcon, rain))
        }

        
        return weeklyWeather
    }
    
    
    
}
