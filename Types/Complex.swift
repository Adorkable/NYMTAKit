//
//  Complex.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import GTFSKit

/// Complex, generally used to organize multiple stations
public struct Complex: Decodable {
    /// ID
    public let id: UInt

    /// Name
    public let name: String
    
    enum CodingKeys : String, CodingKey {
        case id = "Complex ID"
        case name = "Complex Name"
    }
}
