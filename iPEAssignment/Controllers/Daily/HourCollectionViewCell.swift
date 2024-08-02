//
//  HourCollectionViewCell.swift
//  iPEAssignment
//
//  Created by Jack Swallow on 15/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit


//Represents a single cell in the collection view on current page (main)
class HourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourTime: UILabel!
    @IBOutlet weak var hourTemp: UILabel!
    @IBOutlet weak var hourIcon: UIImageView!
    @IBOutlet weak var hourDay: UILabel!
    @IBOutlet weak var hourDescription: UILabel!
    @IBOutlet weak var hourRainChance: UILabel!
    static let cellHeight : CGFloat = 80
}
