//
//  DailyViewModel.swift
//  iPEAssignment
//
//  Created by Jack Swallow on 17/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit
import SwiftyJSON

struct DailyViewModel{
    //Connection to model
    private var dailyWeatherModel : DailyWeather?

    init() {
        if let data : JSON = Utility.readJsonFile(fileName: "OneCall") {
            dailyWeatherModel = DailyWeather(data: data)
        }
    }
    
    func getFormattedDailyWeather() ->([(date: String, time: String, tempString: String, weatherDescription: String, weatherIcon : UIImage?, precipitation: String)]){
        var dailyWeather = [(String, String, String, String, UIImage?, String)]()
        guard let dWM = dailyWeatherModel else {return([("", "", "", "", nil, "")])}
        
        let today = dWM.getDailyWeather()[0].getDate().toString()
        for hour in dWM.getDailyWeather(){
            let date = getDay(hour:hour, today:today)
            let time = hour.getDate().time()
//            let temp = "00°C"
            let temp = hour.getTemp(type: .actual)
            let tempString = Utility.getTempString(temp: temp)
            let weatherDescription = hour.getWeather().getDesciption().capitalized
            let weatherIcon = UIImage(named: "test") //will refactor to request appropriate icon
            let precipitation = String(hour.getPrecipitation()) + "mm"
            let formattedHour = (date, time, tempString, weatherDescription, weatherIcon, precipitation)
            dailyWeather.append(formattedHour)
        }
        return dailyWeather
    }

    func getDay(hour: BasicWeather, today: String) ->(String){
        if hour.getDate().toString() == today{
            return "Today"
        }else{
            return "Tomorrow"
        }
    }
}
