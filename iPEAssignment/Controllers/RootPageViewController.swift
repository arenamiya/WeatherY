//
//  SharedController.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 6/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import Foundation
import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    //View controllers part of the pageview scrolling
   lazy var viewControllerList:[UIViewController] = {
        let sbMain = UIStoryboard(name: "Main", bundle: nil)
        let sbDaily = UIStoryboard(name: "Daily", bundle: nil)
        let sbWeekly = UIStoryboard(name: "Weekly", bundle: nil)
        
        let currentVC = sbMain.instantiateViewController(withIdentifier: "CurrentVC")
        let dailyVC = sbDaily.instantiateViewController(withIdentifier: "DailyVC")
        let weeklyVC = sbWeekly.instantiateViewController(withIdentifier: "WeeklyVC")
        
        return [currentVC, dailyVC, weeklyVC]
    }()
    var currentIndex : Int = 0
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "wildlands2")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let initialVC = viewControllerList.first {
            self.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        }
        
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        initRootObserver()
        setUpNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        //Used to stylize the pagge control dots
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            } else if subView is UIPageControl {
                self.view.bringSubview(toFront: subView)
            }
        }
        super.viewDidLayoutSubviews()
    }
    func setUpNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    
}

//PageView Controller functionality
extension RootPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewControllerList.index(of: viewController) else {return nil}
        
        var prevIndex = index - 1
        
        if prevIndex < 0 {
            prevIndex = viewControllerList.count - 1
        }
    
        return viewControllerList[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewControllerList.index(of: viewController) else {return nil}
        var nextIndex = index + 1
        
        if nextIndex > viewControllerList.count - 1 {
            nextIndex = 0
        }
        
        return viewControllerList[nextIndex]
    }
    
    func presentationCount(for pvc: UIPageViewController) -> Int {
        return viewControllerList.count
    }
    func presentationIndex(for pvc: UIPageViewController) -> Int {
        return currentIndex
    }
}

//Notification Functionality
extension RootPageViewController {
    func initRootObserver() {
        //Adding RootViewController as observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateStyle(_:)), name: Notification.Name("appStyleChanged"), object: nil)
        
        //Posting notification to update view with current user settings
        let style = UserDefaults.standard.object(forKey: "appStyle") as! String
        NotificationCenter.default.post(name: Notification.Name("appStyleChanged"), object: nil, userInfo: ["appStyle" : style])
    }
    
    
    //Update Style Notification
    @objc  func updateStyle(_ notification: NSNotification) {
        if let appStyle : Style = Style.init(styleString: notification.userInfo?["appStyle"] as! String) {
            
            let backgroundColour = { () -> UIColor in
                switch appStyle {
                case .color:
                    return UIColor.init(red: 244.0/255.0, green: 215.0/255.0, blue: 151.0/255.0, alpha: 1)
                case .picture:
                    return UIColor.clear
                case .video:
                    return UIColor.clear
                }
            }()
            for vc in viewControllerList {
                vc.view.backgroundColor = backgroundColour
            }
        }
    }
    
}
