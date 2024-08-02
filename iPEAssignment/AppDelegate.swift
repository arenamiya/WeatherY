//
//  AppDelegate.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 27/7/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //Get current location when app boots up
    lazy var geocoder = CLGeocoder()
    let locationManager = CLLocationManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
            UserDefaults.standard.set("picture", forKey: "appStyle")
            UserDefaults.standard.set("celsius", forKey: "tempType")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        performReverseGeocode(lat: locValue.latitude, long: locValue.longitude)
    }
    
    func performReverseGeocode(lat : CLLocationDegrees, long : CLLocationDegrees) {
        //Allows location to be set as a city even if the user enters something ambiguous (ie. America)
        //Reverse Geocoding (Coordinates --> Address)
        let location = CLLocation(latitude: lat, longitude: long)
        //Prevent searching while geocoding is working
        self.geocoder.reverseGeocodeLocation(location, completionHandler:  {(placemarks, error) in
            //Update View
            self.processReverseResponse(withPlacemarks: placemarks, error: error)
        })
    }
    
    private func processReverseResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {

        if let error = error {
            print(error)
            setDummyData()
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first,
                let locality = placemark.locality, let country = placemark.country {
                
                let city = City(name: locality, country: country, lat: placemark.location?.coordinate.latitude ?? 0, long: placemark.location?.coordinate.longitude ?? 0)
                let userDefaults = UserDefaults.standard
                do {
                    try userDefaults.setObject(city, forKey: "currentCity")
                    try userDefaults.setObject(city, forKey: "weatherCity")
                    
                     NotificationCenter.default.post(name: Notification.Name("loadData"), object: nil)
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                setDummyData()
            }
        }
    }
    
    //If error occurs, set values to dummy data
    private func setDummyData() {
    
        let city = City(name: "Melbourne", country: "Australia", lat: -37.8136, long: -144.9631)
        UserDefaults.standard.set(city, forKey: "currentCity")
        UserDefaults.standard.set(city, forKey: "weatherCity")
    }
}
