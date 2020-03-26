//
//  UIViewController+Ext.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 26/03/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//


import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    func presentKNAlertOnMainThread(title: String, message: String){
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default))
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle =  .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
        
    func showLoadingScreen() {
            
            containerView = UIView(frame: view.bounds)
            view.addSubview(containerView)
            
            containerView.backgroundColor = .systemBackground
            containerView.alpha = 0
            
            UIView.animate(withDuration: 0.25) {
                containerView.alpha = 0.8
            }
            let activityIndicator = UIActivityIndicatorView(style: .large)
            containerView.addSubview(activityIndicator)
            
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            activityIndicator.startAnimating()
        
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
        
    }
  
    
    func presentSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemOrange
        present(safariVC, animated: true, completion: nil)
    }
}
