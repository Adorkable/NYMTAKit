 //
//  Colors.swift
//  NYMTAKitTests
//
//  Created by Ian Grossberg on 9/8/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import XCTest
import NYMTAKit

class ColorsTest: XCTestCase {
    func testParse() {
        guard let container: Colors = createFromCSV(bundle: Bundle(for: type(of: self)), forResource: "MTA - colors.fixed", withExtension: "csv") else {
            return
        }

        XCTAssertEqual(container.values.count, 27, "Expected 27 colors")

        XCTAssertEqual(container.colorsByMode.keys.count, 4, "Expected 4 Modes")

        XCTAssertEqual(container.colorByLineOrBranch.keys.count, 39, "Expected 39 Lines / Branches")
    }
}
