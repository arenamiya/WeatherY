//
//  SearchViewController.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 14/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class SearchViewController: UIViewController {
    
    var searchController : UISearchController!
    
    //View Connections
    @IBOutlet weak var stackView: UIStackView!
        //CurrentLocationStack
    @IBOutlet weak var currentCity: UILabel!
    @IBOutlet weak var currentCountry: UILabel!
    @IBOutlet weak var currentCoord: UILabel!
    
        //WeatherLocationStack
    @IBOutlet weak var weatherCity: UILabel!
    @IBOutlet weak var weatherCountry: UILabel!
    @IBOutlet weak var weatherCoord: UILabel!
    
        //Other View Connections
    @IBOutlet weak var status: UILabel!
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "wildlands2")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //Used for getting locations searched by user
    lazy var geocoder = CLGeocoder()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up search bar
        initView()
    }
    
    //Updates neccessary components of view when device in rotated
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        super.viewDidLayoutSubviews()
        //landscape
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        //portrait
        } else {
           stackView.axis = .vertical
        }
    }
    
    //Button actions
    
        //Return to page view controller (main)
    @IBAction func backButton(_ sender: Any) {
        self.searchController.isActive = false
        dismiss(animated: true, completion: nil)
    }
    
        //Sync current location & weather location
    @IBAction func sync(_ sender: Any) {
        var currentCityDetails : City
        do {
            currentCityDetails = try UserDefaults.standard.getObject(forKey: "currentCity", castTo: City.self)
            
        } catch {
            print(error.localizedDescription)
            currentCityDetails = City(name: "Melbourne", country: "Australia", lat: -37.8136, long: -144.9631)
        }
        status.text = "Synced!"
        weatherCity.text = "City: \(currentCityDetails.getName())"
        weatherCountry.text = "Country: \(currentCityDetails.getCountry())"
        weatherCoord.text = "Coordinates: \(currentCityDetails.getCoordinate(type: .lat)) : \(currentCityDetails.getCoordinate(type: .long))"
    }
    
    
    
}

//Search Bar protocol functions
extension SearchViewController : UISearchBarDelegate, UISearchResultsUpdating {
    //Performs forward geocode when user hits search (Address->Lat/Long)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performForwardGeocode()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}

//Initialising & Updating view
extension SearchViewController {
    
    func initView() {
        setUpSearchBar()
        setUpLabels()
        setUpBackground()
    }
    func setUpNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setUpSearchBar() {
        setUpNavBar()
        //Search Controller & navigation bar set up
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        self.searchController.hidesNavigationBarDuringPresentation = false
    }
    
    func setUpLabels() {
        //Configuration
        weatherCity.adjustsFontSizeToFitWidth = true
        weatherCountry.adjustsFontSizeToFitWidth = true
        weatherCoord.adjustsFontSizeToFitWidth = true
        currentCity.adjustsFontSizeToFitWidth = true
        currentCountry.adjustsFontSizeToFitWidth = true
        currentCoord.adjustsFontSizeToFitWidth = true
        
        //Initial Texts
        status.text = ""
        status.addShadow(colour: UIColor.black.cgColor, radius: 8, offsetWidth: 0, offsetHeight: 0)
        var currentCityDetails : City
        var weatherCityDetails : City
        do {
            currentCityDetails = try UserDefaults.standard.getObject(forKey: "currentCity", castTo: City.self)
            weatherCityDetails = try UserDefaults.standard.getObject(forKey: "weatherCity", castTo: City.self)
        
        } catch {
            print(error.localizedDescription)
            currentCityDetails = City(name: "Melbourne", country: "Australia", lat: -37.8136, long: -144.9631)
            weatherCityDetails = City(name: "Melbourne", country: "Australia", lat: -37.8136, long: -144.9631)
        }

        currentCity.text = "City: \(currentCityDetails.getName())"
        currentCountry.text = "Country: \(currentCityDetails.getCountry())"
        currentCoord.text = "Coordinates: \(currentCityDetails.getCoordinate(type: .lat)) : \(currentCityDetails.getCoordinate(type: .long))"
        weatherCity.text = "City: \(weatherCityDetails.getName())"
        weatherCountry.text = "Country: \(weatherCityDetails.getCountry())"
        weatherCoord.text = "Coordinates: \(weatherCityDetails.getCoordinate(type: .lat)) : \(weatherCityDetails.getCoordinate(type: .long))"
        
    }
    
    func setUpBackground() {
        //Background Image
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        //Blur effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.5)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
        
        //StackView Background
        stackView.addBackground(backgroundColor: .gray, alpha: 0.5, radiusSize: 20)
    }
    func presentError() {
        self.status.text = "Error has occured"
    }
}

//Geocode functionality
extension SearchViewController {
    
    func performForwardGeocode() {
        // Generate address string from user searchTerms
        if let address = searchController.searchBar.text {
            //Prevent searching while geocoding is working
            searchController.isActive = false
            // Forward Geocoding (Address --> Cooridnates)
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) in
                // Update View
                self.processResponse(withPlacemarks: placemarks, error: error)
            })
            //Allow access to search bar (geocoding is complete)
            self.searchController.isActive = true
        }
    }
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {

        //Error message if no location was found
        if let error = error {
            print("Error: \(error)")
            presentError()
        } else {
            var placemark : CLPlacemark?
            var location : CLLocation?
            
            //Check if multiple placemarks were returned, and pick the first one
            if let placemarks = placemarks {
                placemark = placemarks.first
                location = placemark?.location
            }
            
            //Update view components
            if let placemark = placemark, let location = location,
                let locality = placemark.locality, let country = placemark.country {
                let weatherCityDetails : [String] = [locality,country, location.coordinate.latitude.description , location.coordinate.longitude.description ]
                self.status.text = "Success!"
                self.weatherCity.text = "City: \(locality)"
                self.weatherCountry.text = "Country: \(country)"
                self.weatherCoord.text = "Coordinates: \(location.coordinate.latitude) : \(location.coordinate.longitude)"
                
                //Update user settings
                UserDefaults.standard.set(weatherCityDetails, forKey: "weatherCity")
                
                //Test purposes only
                let currentWeatherCity : City = .init(name: self.weatherCity.text!, lat: location.coordinate.latitude, long: location.coordinate.longitude)
                Settings.sharedInstance.setWeatherCity(newCity: currentWeatherCity)
                
            } else {
                presentError()
            }
        }
    }
}
