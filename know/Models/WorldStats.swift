//
//  World Stats.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 03/04/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation
struct World: Codable, Hashable {
    let activeCases: String
    let country: String
    let critical: String
    let newCases: String
    let newDeaths: String
    let totalCases: Int
    let totalCases1MPop: String
    let totalDeaths: Int
    let totalDeaths1MPop: String
    let totalRecovered: Int
    
}
