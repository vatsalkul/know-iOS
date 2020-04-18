//
//  StatsDetailViewController.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 04/04/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import Charts

class StatsDetailViewController: UIViewController {
    
    var stats: World?
    
    
    @IBOutlet weak var barChart: HorizontalBarChartView!
    
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var plusActiveCases: UILabel!
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var viewFive: UIView!
    
    
    @IBOutlet weak var criticalLabel: UILabel!
    
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var newDeathsLabel: UILabel!
    
    @IBOutlet weak var casesOneMLabel: UILabel!
    @IBOutlet weak var deathsOneMLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = stats?.country
        setChart()
        setupView()
        setValues()
    }
    
    
    func setChart() {
        
        let total = ["Deaths", "Recovered", "Cases"]
        let values = [stats!.totalDeaths, stats!.totalRecovered,  stats!.totalCases]
        
        
        barChart.noDataText = "Error Loading graph"
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<total.count {
            let data = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(data)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries)
        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.data = chartData
        barChart.legend.enabled = false
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: total)
        barChart.xAxis.granularity = 1.0
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.drawGridLinesEnabled = false
        chartDataSet.colors = [UIColor.red, UIColor.orange, UIColor.green]
        chartDataSet.valueColors = [.label]
        barChart.xAxis.labelTextColor = .label
        barChart.leftAxis.enabled = false
        barChart.rightAxis.enabled = false
        barChart.extraRightOffset = 20
        barChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    
    func setupView() {
        let views = [viewOne, viewTwo, viewThree, viewFour, viewFive]
        for view in views {
            view?.layer.cornerRadius = 8
            view?.layer.shadowColor = UIColor.systemGray2.cgColor
            view?.layer.shadowOffset = CGSize(width: 3, height: 3)
            view?.layer.shadowOpacity = 0.7
            view?.layer.shadowRadius = 4.0
        }
        
    }
    
    
    func setValues() {
           
           criticalLabel.text = stats?.critical == "" ? "0" : stats?.critical
           deathLabel.text = String(stats!.totalDeaths)
           newDeathsLabel.text = stats?.newDeaths
           casesOneMLabel.text = stats?.totalCases1MPop == "" ? "0" : stats?.totalCases1MPop
           deathsOneMLabel.text = stats?.totalDeaths1MPop == "" ? "0" : stats?.totalDeaths1MPop
           activeCases.text = stats?.activeCases
           plusActiveCases.text = stats?.newCases
           
       }
}
