//
//  DevTeamViewController.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 28/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit

class DevTeamViewController: UIViewController {

    
    @IBOutlet weak var parentStack: UIStackView!
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        super.viewDidLayoutSubviews()
        //landscape
        if UIDevice.current.orientation.isLandscape {
            parentStack.axis = .horizontal
            //portrait
        } else {
            parentStack.axis = .vertical
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
