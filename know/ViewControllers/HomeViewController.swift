//
//  HomeViewController.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 27/03/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var totalCaseLabel: UILabel!
    var dashboard: Dashboard?
    var totalDeath = PieChartDataEntry(value: 0)
    var totalRecovered = PieChartDataEntry(value: 0)
    var numberOfDownloadsDataEntry = [PieChartDataEntry]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        chartView.noDataText = ""
        customView.layer.cornerRadius = 5
        getHome()
        
    }
    
    func updatChartData() {
        totalDeath.value = Double(dashboard!.totalDeaths)
        totalRecovered.value = Double(dashboard!.totalRecovered)
        totalDeath.label = "Deaths"
        totalRecovered.label = "Recovered"
        numberOfDownloadsDataEntry = [totalDeath, totalRecovered]
        chartView.chartDescription?.text = ""
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntry, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.systemRed, UIColor.systemBlue]
        chartDataSet.colors = colors as! [NSUIColor]
        
        chartView.data = chartData
        
    }
    
    
    func getHome() {
        showLoadingScreen()
        NetworkManager.shared.getDashboard() { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case.success(let home):
                
                self.dashboard = home
                DispatchQueue.main.async {
                    self.totalCaseLabel.text = String(self.dashboard!.totalCases)
                }
                
                self.updatChartData()
                self.dismissLoadingView()
                
            case.failure(let error):
                self.presentKNAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
                
            }
            
        }
    }
    
}
