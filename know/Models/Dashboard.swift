//
//  Dashboard.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 27/03/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation
struct Dashboard: Codable {
    let totalCases: Int
    let totalDeaths: Int
    let totalRecovered: Int
    let activeCases: Int
    let closedCases: Int
}
