//
//  Complex.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import GTFSKit

public struct Complex: Decodable {
    public let id: UInt
    public let name: String
    
    enum CodingKeys : String, CodingKey {
        case id = "Complex ID"
        case name = "Complex Name"
    }
}
