//
//  HomeViewController.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 27/03/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import Charts
import UPCarouselFlowLayout

class HomeViewController: UIViewController {
    
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Data used in Collection View
    var data = ["","","","",""]
    var titles = ["Total Cases", "Total Deaths", "Total Recovered", "Active Cases", "Closed Cases"]
    var colors = [UIColor.systemBlue, UIColor.systemRed, UIColor.systemGreen, UIColor.systemOrange, UIColor.systemIndigo]
    
    //Data
    var dashboard: Dashboard?
    var totalDeath = PieChartDataEntry(value: 0)
    var totalRecovered = PieChartDataEntry(value: 0)
    var numberOfDownloadsDataEntry = [PieChartDataEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.noDataText = ""
        collectionView.isHidden = true
        getHome()
        configureCollectionView()
        
    }
    
    func updatChartData() {
        
        //Configure chart view
        chartView.holeColor = .systemBackground
        chartView.entryLabelColor = .systemBackground
        chartView.legend.enabled = false
        
        //Configuring data
        totalDeath.value = Double(dashboard!.totalDeaths)
        totalRecovered.value = Double(dashboard!.totalRecovered)
        totalDeath.label = "Deaths"
        totalRecovered.label = "Recovered"
        numberOfDownloadsDataEntry = [totalDeath, totalRecovered]
        
        //Configure Chart
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntry, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.systemRed, UIColor.systemGreen]
        chartDataSet.colors = colors
        chartView.data = chartData
        
    }
    
    
    func getHome() {
        showLoadingScreen()
        NetworkManager.shared.getDashboard() { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case.success(let home):
                
                self.dashboard = home
                //update data used for collection
                self.data = [self.updateValues(value: self.dashboard!.totalCases),
                             self.updateValues(value: self.dashboard!.totalDeaths),
                             self.updateValues(value: self.dashboard!.totalRecovered),
                             self.updateValues(value: self.dashboard!.activeCases),
                             self.updateValues(value: self.dashboard!.closedCases)]
                
                //Display fetched data
                DispatchQueue.main.async {
                    self.updatChartData()
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                }
                self.dismissLoadingView()
                
            case.failure(let error):
                self.presentKNAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
    func updateValues(value: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:value))
        return formattedNumber!
        
    }
    
    
    func configureCollectionView() {
        
        //Data source and delegate setup of collection view
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //Defining layout od collection view
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 60, height: collectionView.frame.size.height - 100)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = flowLayout
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Number of entries available in Dashboard Model
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.titleLabel.text = titles[indexPath.row]
        cell.countLabel.text = data[indexPath.row]
        cell.cntView.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
}
