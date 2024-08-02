//
//  WeeklyViewController.swift
//  iPEAssignment
//
//  Created by Aren Carter on 19/8/20.
//  Copyright © 2020 s3743803_s3728738_s3541003. All rights reserved.
//

import UIKit

class WeeklyViewController: UIViewController, WeatherVC {
    @IBOutlet weak var weekCollectionView: UICollectionView!
    
    lazy var weeklyWeather = {weeklyViewModel.getFormattedWeeklyWeather()}()
    
    @IBOutlet weak var pageTitle: UILabel!
    private var weeklyViewModel = WeeklyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weekCollectionView.delegate = self
        self.weekCollectionView.dataSource = self
        initView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: (.now() + .milliseconds(500))) {
            self.weekCollectionView.flashScrollIndicators()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.weekCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func initView() {
        weekCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
        pageTitle.adjustsFontSizeToFitWidth = true
        pageTitle.addShadow(colour: UIColor.black.cgColor)
        pageTitle.text = "The Week's Weather"
    }
    
    func reloadData() {
        weeklyWeather = weeklyViewModel.getFormattedWeeklyWeather()
        self.weekCollectionView.reloadData()
    }
    

}


extension WeeklyViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyViewModel.getFormattedWeeklyWeather().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customDayCell", for: indexPath) as! DayCollectionViewCell
        cell.date.text = weeklyWeather[indexPath.row].date
        cell.temperatures.text = "\(weeklyWeather[indexPath.row].min) - \(weeklyWeather[indexPath.row].max)"
        cell.rain.text = weeklyWeather[indexPath.row].rain + " of rain"
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        
        cell.date.adjustsFontSizeToFitWidth = true
        cell.temperatures.adjustsFontSizeToFitWidth = true
        cell.rain.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    
    //Defines cell dimensions
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.size.width;
        return CGSize(width: cellWidth, height: CollectionViewCell.cellHeight)
    }
}
