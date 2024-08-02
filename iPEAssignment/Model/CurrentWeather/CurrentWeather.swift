//
//  CurrentWeather.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 5/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation
import SwiftyJSON

class CurrentWeather : BasicWeather {
    
    //Data Containers
    
    //Initialisers
    
    override init(data: JSON){
        //Initlise variables from JSON data (API call or file)
        let currentData = data["current"]
        super.init(data: currentData)
        self.setPrecipitation(rain: data["minutely"][0]["precipitation"].double ?? 0)
    }
    //testing
    func getCurrentWeatherDetails() -> (temp: Double, city: City, date: CustomDate, weather: Weather) {
        return(getTemp(type: .actual), getCity(), getDate(), getWeather())
    }
}
