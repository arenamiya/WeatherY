//
//  Setings.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 9/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation

class Settings {
    static let sharedInstance = Settings()
    
    private var tempType : UnitTemperature
    private var appStyle : Style
    private var currentCity : City
    private var weatherCity : City
    
    init() {
        self.tempType = .celsius
        self.appStyle = .picture
        self.currentCity = .init(name: "Melbourne", lat: -37.813629, long: 144.963058)
        self.weatherCity = .init(name: "Melbourne", lat: -37.813629, long: 144.963058)
    }
    
    func setTempType(tempType : UnitTemperature) {
        self.tempType = tempType
    }
    
    func setAppStyle(style : Style) {
        self.appStyle = style
    }
    
    func getTempType() -> UnitTemperature {
        return tempType
    }
    
    func getAppStyle() -> Style {
        return appStyle
    }
    
    func setWeatherCity(newCity : City) {
        self.weatherCity = newCity
    }
}
