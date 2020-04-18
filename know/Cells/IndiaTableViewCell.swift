//
//  IndiaTableViewCell.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 06/04/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class IndiaTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var curedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(india: India){
        stateLabel.text = india.state
        confirmedLabel.text = india.confirm
        curedLabel.text = "Cured: \(india.cured)"
        deathLabel.text = "Deaths: \(india.death)"
    }
    
}
