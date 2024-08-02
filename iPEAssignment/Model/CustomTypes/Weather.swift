//
//  Weather.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 5/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation

struct Weather{
    
    private var main : String
    private var iconID: String
    private var description: String
    
    init(main: String, iconID: String, description: String) {
        self.main = main
        self.iconID = iconID
        self.description = description
    }
    
    func getMain() -> String {
        return main
    }
    
    func geticonID() -> String {
        return iconID
    }
    
    func getDesciption() -> String {
        return description
    }
}

