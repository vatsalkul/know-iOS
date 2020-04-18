//
//  StatsViewController.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 03/04/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import Charts

class StatsViewController: UIViewController {

    var stats: [World] = []
    enum Section { case main }
    var countryName: String!
    @IBOutlet weak var tableView: UITableView!
    var isSearching = false
    var filterCountry: [World] = []

    var dataSource: UITableViewDiffableDataSource<Section, World>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getStats()
        configureTableView()
        configureDataSource()
        configureSearchController()

    }
    
    
    func configureTableView() {
        tableView.delegate = self
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    
    func configureSearchController() {
           let searchController = UISearchController()
           searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
           searchController.searchBar.placeholder = "Search for a country"
           navigationItem.searchController = searchController
           searchController.obscuresBackgroundDuringPresentation = false
       
       }
    
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, World>(tableView: tableView) { (tableView, indexPath, stats) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell

            cell.set(world: stats)
            
            return cell
        }
    }
    
    
    func updateData(on world: [World]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, World>()
        snapshot.appendSections([.main])
        snapshot.appendItems(world)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
       
    }
    
    
    func getStats() {
        showLoadingScreen()
        NetworkManager.shared.getWorld() { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case.success(let worldStats):
                
                self.stats = worldStats
                self.updateData(on: self.stats)
                
            case.failure(let error):
                self.presentKNAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }

}

extension StatsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = dataSource.itemIdentifier(for: indexPath) {
            performSegue(withIdentifier: "cellToDetail", sender: movie)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToDetail" {
            let desVC = segue.destination as! StatsDetailViewController
            desVC.stats = sender as? World
        }
    }
    
}
extension StatsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filterCountry = stats.filter({ $0.country.lowercased().contains(filter.lowercased()) })
        updateData(on: filterCountry)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: stats)
    }
}
