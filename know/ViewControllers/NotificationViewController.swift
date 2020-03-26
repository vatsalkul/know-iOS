//
//  ViewController.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 26/03/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import SafariServices

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var allNotifications = [Notification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        getNotifications()
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func getNotifications() {
        self.showLoadingScreen()
        NetworkManager.shared.getNotifications() { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case.success(let notifications):
                
                self.allNotifications = notifications
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case.failure(let error):
                self.presentKNAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
                
            }
            
        }
        
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? NotificationTableViewCell else {return UITableViewCell()}
        
        if let imageUrl = URL(string: allNotifications[indexPath.row].image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.NotificationImageView.image = image
                    }
                }
            }
            
        }
        cell.titleLabel.text = String(allNotifications[indexPath.row].title)
        cell.NotificationImageView.layer.cornerRadius = 6.0
        cell.NotificationImageView.layer.masksToBounds = true
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let safariVC = SFSafariViewController(url: URL(string: allNotifications[indexPath.row].link)!)
        present(safariVC, animated: true, completion: nil)
        
    }
    
}

