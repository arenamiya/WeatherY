//
//  LoadingViewController.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 29/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(self.loadPages(_:)), name: Notification.Name("loadData"), object: nil)
        
        activityIndicator.color = UIColor.black

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator.startAnimating()
    }
    
    @objc  func loadPages(_ notification: NSNotification) {
        DispatchQueue.main.asyncAfter(deadline: (.now() + .milliseconds(1000))) {
            self.activityIndicator.startAnimating()
            self.performSegue(withIdentifier: "loadingOver", sender: nil)
        }
}
}
