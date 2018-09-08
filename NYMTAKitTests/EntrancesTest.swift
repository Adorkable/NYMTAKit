//
//  EntrancesTest.swift
//  NYMTAKitTests
//
//  Created by Ian Grossberg on 9/8/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import XCTest
import NYMTAKit

class EntrancesTest: XCTestCase {
    func testParse() {
        guard let container: Entrances = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "MTA - StationEntrances", withExtension: "csv") else {
            return
        }
        
        XCTAssertEqual(container.values.count, 1866, "Expected 1866 entrances")
    }
}
