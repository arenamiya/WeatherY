//
//  ViewModel.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 7/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit
import SwiftyJSON

struct CurrentViewModel{
    //Connection to model
    private var cw : CurrentWeather?
    
    init() {
        if let data : JSON = Utility.readJsonFile(fileName: "OneCall") {
            cw = CurrentWeather(data: data)
        }
    }
    
    func getCurrentWeatherSummary() ->(temp: String, cityName: String, date: String, weatherDescription: String, weatherIcon : UIImage?) {
        guard let cw = cw else {return ("Temp", "Location", "0/00/0000", "weather", nil)}
        let details = cw.getCurrentWeatherDetails()
        let temp = Utility.getTempString(temp: details.temp)
        let cityName = details.city.getName()
        let date = details.date.toString()
        let weatherDescription = details.weather.getMain() + " " + details.weather.getDesciption()
        
        //Will be refacotred with http request for image
        let weatherImage = UIImage(named: "test")
        return (temp, cityName, date, weatherDescription, weatherImage)
    }
    
    func getCollectionViewDetails() -> [DataType : String] {
        guard let cw = cw else {return [:]}
        var data : [DataType : String] = [:]
        
        data[.temperature] = Utility.getTempString(temp: cw.getTemp(type: .actual))
        data[.feelsLike] = Utility.getTempString(temp: cw.getTemp(type: .feelsLike))
        data[.sunrise] = "\(cw.getSunTime(time: .sunrise).UTCToLocal())"
        data[.sunset] = "\(cw.getSunTime(time: .sunset).UTCToLocal())"
        data[.rain] = "\(cw.getPrecipitation())mm"
        data[.windSpeed] = "\(cw.getWind(type: .speed))m/s"
        data[.humidity] = "\(cw.getHumidity())%"
        data[.pressure] = "\(cw.getPressure())hPa"
        data[.clouds] = "\(cw.getClouds())%"
        data[.visibility] = "\(cw.getVisibility())m"
        data[.dewPoint] = Utility.getTempString(temp: cw.getDewPoint())
        data[.UIIndex] = "\(cw.getUVI())UI"
        
        return data
    }
}
