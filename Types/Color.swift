//
//  Color.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import UIKit

public struct Color: Decodable {
    public enum Mode: CustomStringConvertible {
        case nyctSubway
        case lirr
        case metroNorth
        case bridgesAndTunnels
        case unknown
        
        init?(from: String) {
            var found: Mode?
            for mode in Mode.all {
                if mode.description == from {
                    found = mode
                    break
                }
            }
            if let found = found {
                self = found
            } else {
                return nil
            }
        }
        
        public static let all: [Mode] = [
            .nyctSubway,
            .lirr,
            .metroNorth,
            .bridgesAndTunnels,
            .unknown
        ]
        
        public var description: String {
            switch self {
            case .nyctSubway:
                return "NYCT Subway"
            case .lirr:
                return "LIRR"
            case .metroNorth:
                return "Metro-North"
            case .bridgesAndTunnels:
                return "Bridges & Tunnels"
            case .unknown:
                return "Unknown"
            }
        }
    }
    
    public var mode: Mode {
        guard let result = Mode(from: self.modeString) else {
            return .unknown
        }
        return result
    }
    let modeString: String
    
    public let lineOrBranch: [String]
    
    public func asUIColor() throws -> UIColor {
        return try UIColor(hex: self.rgbHex)
    }
    public let rgbHex: String
    public let pantoneCVC: String
    public let cmyk: String
    
    enum CodingKeys : String, CodingKey {
        case modeString = "MTA Mode"
        case lineOrBranch = "Line/Branch"
        case rgbHex = "RGB Hex"
        case pantoneCVC = "Pantone CVC"
        case cmyk = "CMYK"
    }
}
