//
//  IndiaStatsViewController.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 06/04/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class IndiaStatsViewController: UIViewController {

    var india: [India] = []
    enum Section { case main }
    var isSearching = false
    var filterStates: [India] = []
    var dataSource: UITableViewDiffableDataSource<Section, India>!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStats()
        configureTableView()
        configureSearchController()
        configureDataSource()
    }
   
    
    func configureTableView() {
        tableView.delegate = self
        tableView.rowHeight = 132
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    
    func configureSearchController() {
           let searchController = UISearchController()
           searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
           searchController.searchBar.placeholder = "Indian State"
           navigationItem.searchController = searchController
           searchController.obscuresBackgroundDuringPresentation = false
       
       }
    
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, India>(tableView: tableView) { (tableView, indexPath, india) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "indiaCell", for: indexPath) as! IndiaTableViewCell

            cell.set(india: india)
            
            return cell
        }
    }
    
    
    func updateData(on india: [India]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, India>()
        snapshot.appendSections([.main])
        snapshot.appendItems(india)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
       
    }
    
    func getStats() {
        showLoadingScreen()
        NetworkManager.shared.getIndianStates() { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case.success(let indiaStats):
                
                self.india = indiaStats
                self.updateData(on: self.india)
                
            case.failure(let error):
                self.presentKNAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }

}

extension IndiaStatsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filterStates = india.filter({ $0.state.lowercased().contains(filter.lowercased()) })
        updateData(on: filterStates)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: india)
    }
}

extension IndiaStatsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let stats = dataSource.itemIdentifier(for: indexPath) {
            self.presentDetailViewOnMainThread(state: stats.state, body: "\(stats.confirm) Confirmed\n\(stats.cured) Cured\n\(stats.death) Death", buttonTitle: "Done")
        }
        
        
        
    }
    
}

