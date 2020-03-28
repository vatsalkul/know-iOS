//
//  HomeCollectionViewCell.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 29/03/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.titleLabel.textColor = .white
            self.countLabel.textColor = .white
            self.cntView.layer.cornerRadius = 10
            self.cntView.layer.shadowColor = UIColor.systemGray2.cgColor
            self.cntView.layer.shadowOpacity = 0.5
            self.cntView.layer.shadowRadius = 10
            self.cntView.layer.shadowOffset = .zero
            self.cntView.layer.shadowPath = UIBezierPath(rect: self.cntView.bounds).cgPath
            self.cntView.layer.shouldRasterize = true
        }
        
    }
    
    
}
