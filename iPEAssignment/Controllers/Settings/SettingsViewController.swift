//
//  SettingsViewController.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 12/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    //View Connections
    @IBOutlet weak var appStyleControl: UISegmentedControl!
    @IBOutlet weak var tempTypeControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
    }
    @IBAction func updateAppStyle(_ sender: UISegmentedControl) {
        var appStyle = "";
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set("color", forKey: "appStyle")
            appStyle = "color"
        case 1:
            UserDefaults.standard.set("picture", forKey: "appStyle")
            appStyle = "picture"
        case 2:
            UserDefaults.standard.set("video", forKey: "appStyle")
            appStyle = "video"
        default:
            UserDefaults.standard.set("color", forKey: "appStyle")
            appStyle = "color"
        }
        
        //Notify observer to update app's views
        NotificationCenter.default.post(name: Notification.Name("appStyleChanged"), object: nil, userInfo: ["appStyle" : appStyle])
    }
    @IBAction func updateTempType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set("celsius", forKey: "tempType")
        case 1:
            UserDefaults.standard.set("fahrenheit", forKey: "tempType")
        case 2:
            UserDefaults.standard.set("kelvin", forKey: "tempType")
        default:
            UserDefaults.standard.set("celsius", forKey: "tempType")
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setUpView() {
        self.title = "Settings"
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .darkGray
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        let appStyle : Style = .init(styleString: UserDefaults.standard.object(forKey: "appStyle") as! String)
        switch appStyle {
        case .color:
            appStyleControl.selectedSegmentIndex = 0
        case .picture:
            appStyleControl.selectedSegmentIndex = 1
        case .video:
            appStyleControl.selectedSegmentIndex = 2
        }
        
        let tempStyle : TempType = .init(tempString: UserDefaults.standard.object(forKey: "tempType") as! String)
        switch tempStyle {
        case .celsius:
            tempTypeControl.selectedSegmentIndex = 0
        case .fahrenheit:
            tempTypeControl.selectedSegmentIndex = 1
        case .kelvin:
            tempTypeControl.selectedSegmentIndex = 2
        }
    }
    
}

enum Style : String {
    case color, picture, video
    
    init(styleString : String) {
        switch styleString {
        case "color":
            self = .color
        case "picture":
            self = .picture
        case "video":
            self = .video
        default:
            self = .picture
        }
    }
}

enum TempType : String {
    case celsius, fahrenheit, kelvin
    
    init(tempString : String) {
        switch tempString {
        case "celsius":
            self = .celsius
        case "fahrenheit":
            self = .fahrenheit
        case "kelvin":
            self = .kelvin
        default:
            self = .celsius
        }
    }
}
