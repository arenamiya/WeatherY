//
//  Utility.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 6/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Utility {

    static func unixToDate(dt: Double) -> Date {
        
        let date = Date(timeIntervalSince1970: dt)
        return date
    }
    
    
    //Used for test purposes only
    static func readJsonFile(fileName: String) -> JSON? {
        
        //Build file path
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {return nil}
        guard let data = NSData(contentsOfFile: filePath) else {return nil}
    
        //SwiftyJSON
        do {
                let json = try JSON(data: data as Data)
                return json
        } catch{
            print(error)
        }
        return nil
    }
    
    static func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> Double {
        let mf = MeasurementFormatter()
        mf.unitOptions = .providedUnit
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        let value = round(1000 * output.value)/1000
        
        return value
    }
    
    static func getTempString(temp: Double) -> String{
        
        var tempString = String(convertTemp(temp: temp, from: .kelvin, to: Settings.sharedInstance.getTempType())) + "\u{00B0}"
        
        switch Settings.sharedInstance.getTempType() {
        case .kelvin:
            tempString += "K"
        case .celsius:
            tempString += "C"
        case .fahrenheit:
            tempString += "F"
        default:
            tempString += ""
        }
        return tempString
    }
}

