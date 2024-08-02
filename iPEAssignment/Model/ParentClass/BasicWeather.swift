//
//  Basic Weather.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 15/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//
import Foundation
import SwiftyJSON

class BasicWeather {
    
    //Data Containers
    
    private var city : City
    private var date : CustomDate
    //Sunrise & Sunset
    private var sunTimes : [SunTime:CustomTime] = [:]
    //Temp & Feels like
    private var temps : [Temperature:Double] = [:]
    //Wind speed & degrees
    private var wind : [Wind:Double] = [:]
    
    private var precipitation : Double
    private var pressure : Double
    private var humidity : Double
    private var dewPoint : Double
    private var uvi : Double
    private var clouds : Double
    private var visiblity : Double
    private var weather : Weather
    
    
    //Initialisers
    
    init(data: JSON){
            
        //If data is corrupt, just set values to 0
        self.city = City(name: "Melbourne", lat: data["lat"].double ?? 0, long: data["lon"].double ?? 0)
        self.date = CustomDate(dt: data["dt"].double ?? 0)
        
        self.sunTimes[SunTime.sunrise] = CustomTime(dt: data["sunrise"].double ?? 0)
        self.sunTimes[SunTime.sunset] = CustomTime(dt: data["sunset"].double ?? 0)
        
        self.temps[Temperature.actual] = data["temp"].double ?? 0
        self.temps[Temperature.feelsLike] = data["feels_like"].double ?? 0
        
        self.wind[Wind.speed] = data["wind_speed"].double ?? 0
        self.wind[Wind.degrees] = data["wind_deg"].double ?? 0
        
        self.precipitation = data["rain"]["1h"].double ?? 0
        self.pressure = data["pressure"].double ?? 0
        self.humidity = data["humidity"].double ?? 0
        self.dewPoint = data["dew_point"].double ?? 0
        self.uvi = data["uvi"].double ?? 00
        self.clouds = data["clouds"].double ?? 00
        self.visiblity = data["visibility"].double ?? 0
        
        //Weather Paramerters
        let main : String = data["weather"][0]["main"].string ?? ""
        let iconID : String = data["weather"][0]["icon"].string ?? ""
        let description : String = data["weather"][0]["description"].string ?? ""
        self.weather = Weather(main: main, iconID: iconID, description: description)
    }
    
    func getCity() -> City {
        return self.city
    }
    
    func getDate() -> CustomDate {
        return date
    }
    
    func getWeather() -> Weather {
        return self.weather
    }
    
    func getSunTime(time : SunTime) -> CustomTime {
        guard let sunTime = self.sunTimes[time] else {return CustomTime(dt: 0)}
        return sunTime
    }
        
    func getTemp(type : Temperature) -> Double {
        guard let temp = self.temps[type] else {return 0}
        return temp
    }
    
    func addTemp(type: Temperature, temp: Double) {
        self.temps[type] = temp
    }
    
    func getWind(type : Wind) -> Double {
        guard let val = self.wind[type] else {return 0}
        return val
    }
    
    func getPrecipitation() -> Double {
        return self.precipitation
    }
    func setPrecipitation(rain : Double) {
        self.precipitation = rain
    }
    
    func getPressure() -> Double {
        return self.pressure
    }
    
    func getHumidity() -> Double {
        return self.humidity
    }
    
    func getDewPoint() -> Double {
        return self.dewPoint
    }
    
    func getUVI() -> Double {
        return self.uvi
    }
    
    func getClouds() -> Double {
        return self.clouds
    }
    
    func getVisibility() -> Double {
        return self.visiblity
    }
}
