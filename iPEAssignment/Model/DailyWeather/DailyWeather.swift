//
//  DailyWeather.swift
//  iPEAssignment
//
//  Created by Jack Swallow on 9/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation
import SwiftyJSON

//Hourly weather hholds the exact same data as BasicWeather
class DailyWeather {
    
    //next 48 hours of weather
    private var hourlyData = [BasicWeather]()
    //current day's 24 hours of weather
    private var dailyWeather = [BasicWeather]()
    
    
    init(data : JSON) {
        let data = data["hourly"]
        
        for hourlyWeather in data {
            hourlyData.append(BasicWeather(data: hourlyWeather.1))
        }
        
        //populate the firstDay and secondDay arrays, with 12 hours of data in each
        let hrsInDay = 24
        
        for (index, hourlyWeather) in hourlyData.enumerated(){
            
            //Hourly weather day for today
            if index < hrsInDay{
                dailyWeather.append(hourlyWeather)
            }
        }
    }
    
    //return specific hour (indexes between 0 and 47)
    func getDailyWeather() -> [BasicWeather]{
        return dailyWeather
    }
    
}
