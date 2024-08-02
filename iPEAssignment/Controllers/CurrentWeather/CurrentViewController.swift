//
//  ViewController.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 27/7/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController, WeatherVC{
    
    //ViewModel Connection
    private let currenVM = CurrentViewModel()
    //View connections
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var pageTitle: UILabel!
    
    
    lazy var collectionViewData : [DataType : String] = {currenVM.getCollectionViewDetails()}()
    lazy var summaryData = {currenVM.getCurrentWeatherSummary()}()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegation
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //Set-up view
        initView()
        reloadData()
    }
    
    func reloadData() {
         collectionViewData = currenVM.getCollectionViewDetails()
         summaryData = currenVM.getCurrentWeatherSummary()
         populateSummaryData()
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: (.now() + .milliseconds(500))) {
            self.collectionView.flashScrollIndicators()
        }
    }
    
    //Resize collection view cells when layout is altered (ie. device orientation)
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //Adjustments to be done when device's orientation is changed
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        super.viewDidLayoutSubviews()
        //Update subviews
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

extension CurrentViewController {
    func initView() {
        //Background Colours
        self.collectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
        //Summary Labels
        location.adjustsFontSizeToFitWidth = true
        temperature.adjustsFontSizeToFitWidth = true
        location.addShadow(colour: UIColor.black.cgColor)
        date.addShadow(colour: UIColor.black.cgColor)
        temperature.addShadow(colour: UIColor.black.cgColor)
        weatherImage.addShadow(colour: UIColor.blue.cgColor)
        weatherDescription.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
        pageTitle.adjustsFontSizeToFitWidth = true
        pageTitle.addShadow(colour: UIColor.black.cgColor)
        pageTitle.text = "Now"
    }
    
    //Get data from model & update view
    func populateSummaryData() {
        location.text = summaryData.cityName
        date.text = summaryData.date
        temperature.text = summaryData.temp
        weatherDescription.text = summaryData.weatherDescription
        weatherImage.image = summaryData.weatherIcon
    }
    
}

//Collection View Configuration
extension CurrentViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Number of collection view items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let details = currenVM.getCollectionViewDetails()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CollectionViewCell
        
        cell.title.adjustsFontSizeToFitWidth = true
        cell.value.adjustsFontSizeToFitWidth = true
    
        switch indexPath.row {
        case 0:
            cell.title.text = "Temperature"
            cell.value.text = collectionViewData[.temperature]
        case 1:
            cell.title.text = "Feel like"
            cell.value.text = collectionViewData[.feelsLike]
        case 2:
            cell.title.text = "Sunrise"
            cell.value.text = collectionViewData[.sunrise]
        case 3:
            cell.title.text = "Sunset"
            cell.value.text = collectionViewData[.sunset]
        case 4:
            cell.title.text = "Rain"
            cell.value.text = collectionViewData[.rain]
        case 5:
            cell.title.text = "Wind"
            cell.value.text = collectionViewData[.windSpeed]
        case 6:
            cell.title.text = "Humidity"
            cell.value.text = collectionViewData[.humidity]
        case 7:
            cell.title.text = "Pressure"
            cell.value.text = collectionViewData[.pressure]
        case 8:
            cell.title.text = "Clouds"
            cell.value.text = collectionViewData[.clouds]
        case 9:
            cell.title.text = "Visiblity"
            cell.value.text = collectionViewData[.visibility]
        case 10:
            cell.title.text = "Dew Point"
            cell.value.text = collectionViewData[.dewPoint]
        case 11:
            cell.title.text = "UI Index"
            cell.value.text = collectionViewData[.UIIndex]
        default:
            cell.title.text = "Cell \(indexPath.row)"
            cell.value.text = "Cell \(indexPath.row)"
        }
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear

        return cell
    }
    
    //Defines cell dimensions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.size.width;
        return CGSize(width: cellWidth/2, height: CollectionViewCell.cellHeight)
    }
    
}



