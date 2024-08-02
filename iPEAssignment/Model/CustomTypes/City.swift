//
//  City.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 6/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation

struct City : Codable{
    var name : String
    var country : String
    var coordinates : [Double]
    
    //Constructor
    init(name: String, country: String = "", lat: Double, long: Double) {
        self.name = name
        self.country = country
        self.coordinates = [Double]()
        self.coordinates.append(lat)
        self.coordinates.append(long)
    }

    func getName() -> String {
        return name
    }
    
    func getCountry() -> String {
        return country
    }
    
    func getCoordinate(type: Coordinate) -> Double {
        switch type{
        case .lat:
            return self.coordinates[0]
        case .long:
            return self.coordinates[1]
        }
    }
}
