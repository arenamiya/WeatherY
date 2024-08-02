//
//  DailyViewController.swift
//  iPEAssignment
//
//  Created by Isaiah Cuzzupe on 6/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController, WeatherVC {

    
    private var dailyViewModel = DailyViewModel()
    
    lazy var dailyWeather = {dailyViewModel.getFormattedDailyWeather()}()

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dayCollectionView.backgroundColor = UIColor.clear
        
        self.dayCollectionView.delegate = self
        self.dayCollectionView.dataSource = self
        
       initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: (.now() + .milliseconds(500))) {
            self.dayCollectionView.flashScrollIndicators()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.dayCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func initView() {
        //Background Colours
        self.dayCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
        pageTitle.adjustsFontSizeToFitWidth = true
        pageTitle.addShadow(colour: UIColor.black.cgColor)
        pageTitle.text = "Today's Weather"
    }
    func reloadData() {
        dailyWeather = dailyViewModel.getFormattedDailyWeather()
        self.dayCollectionView.reloadData()
    }
}

extension DailyViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyViewModel.getFormattedDailyWeather().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customHourCell", for: indexPath) as! HourCollectionViewCell
        cell.hourTime.text = dailyWeather[indexPath.row].time
        cell.hourDay.text = dailyWeather[indexPath.row].date
        cell.hourDescription.text = dailyWeather[indexPath.row].weatherDescription
        cell.hourTemp.text = dailyWeather[indexPath.row].tempString
        cell.hourIcon.image = dailyWeather[indexPath.row].weatherIcon
        cell.hourRainChance.text = dailyWeather[indexPath.row].precipitation
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = dayCollectionView.frame.size.width;
        return CGSize(width: cellWidth, height: CollectionViewCell.cellHeight)
    }
    
}
