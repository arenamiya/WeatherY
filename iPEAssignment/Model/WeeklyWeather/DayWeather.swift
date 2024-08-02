//
//  Daily.swift
//  iPEAssignment
//
//  Created by Aren Carter on 9/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation
import SwiftyJSON

class DayWeather : BasicWeather {
    private var pop : Double
    
    
    override init(data : JSON){
        
        self.pop = data["pop"].double ?? 0
        super.init(data: data)
        
        self.addTemp(type: .actual, temp:  data["temp"]["day"].double ?? 0)
        self.addTemp(type: .min, temp:  data["temp"]["min"].double ?? 0)
        self.addTemp(type: .max, temp:  data["temp"]["max"].double ?? 0)
        self.addTemp(type: .night, temp:  data["temp"]["night"].double ?? 0)
        self.addTemp(type: .evening, temp:  data["temp"]["evening"].double ?? 0)
        self.addTemp(type: .morning, temp:  data["temp"]["morning"].double ?? 0)
       
        self.addTemp(type: .feelsLikeDay, temp:  data["feels_like"]["day"].double ?? 0)
        self.addTemp(type: .feelsLikeNight, temp:  data["feels_like"]["min"].double ?? 0)
        self.addTemp(type: .feelsLikeNight, temp:  data["feels_like"]["max"].double ?? 0)
        self.addTemp(type: .feelsLikeEvening, temp:  data["feels_like"]["night"].double ?? 0)
        self.addTemp(type: .feelsLikeMorning, temp:  data["feels_like"]["evening"].double ?? 0)
    }
    
    func getPop() -> Double {
        return pop
    }

}
