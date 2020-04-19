//
//  HomeTest.swift
//  knowTests
//
//  Created by Vatsal Kulshreshtha on 20/04/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation
import XCTest
@testable import know
class HomeTests: XCTestCase {
    
    
    func testUpdateValues() {
        let home = HomeViewController()
        let value = 10020
        XCTAssertEqual("10,020", home.updateValues(value: value))
    }
    
}
