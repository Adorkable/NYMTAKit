//
//  ComplexesTest.swift
//  NYMTAKitTests
//
//  Created by Ian Grossberg on 9/8/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import XCTest
import NYMTAKit

class ComplexesTest: XCTestCase {
    func testParse() {
        guard let container: Complexes = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "MTA - StationComplexes", withExtension: "csv") else {
            return
        }
        
        XCTAssertEqual(container.values.count, 32, "Expected 32 complexes")
    }
}
