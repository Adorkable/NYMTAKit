//
//  Complex.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

struct Complex: Decodable {
    let id: UInt
    let name: String
    
    enum CodingKeys : String, CodingKey {
        case id = "Complex ID"
        case name = "Complex Name"
    }
}
