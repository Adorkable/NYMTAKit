//
//  StationsTest.swift
//  NYMTAKitTests
//
//  Created by Ian Grossberg on 9/8/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import XCTest
import NYMTAKit

class StationsTest: XCTestCase {
    func testParse() {
        guard let container: Stations = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "NYC - MTA Subway Stations", withExtension: "csv") else {
            return
        }
        
        XCTAssertEqual(container.values.count, 497, "Expected 497 stations")
        
        XCTAssertEqual(container.stationsByDaytimeRoute.keys.count, 24, "Expected 24 daytime routes")
    }
}
