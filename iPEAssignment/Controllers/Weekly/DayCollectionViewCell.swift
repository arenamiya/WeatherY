//
//  DayCollectionViewCell.swift
//  iPEAssignment
//
//  Created by Aren Carter on 19/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatures: UILabel!
    @IBOutlet weak var rain: UILabel!
    
    
    
    static let cellHeight : CGFloat = 80
    
}
