//
//  CollectionViewCell.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 7/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit


//Represents a single cell in the collection view on current page (main)
class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UILabel!
    static let cellHeight : CGFloat = 80
}
