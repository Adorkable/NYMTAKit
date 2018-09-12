//
//  Color.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//


#if os(iOS)
import UIKit
import HEXColor
#else
import Cocoa
#endif
import GTFSKit

public struct Color: Decodable {
    // TODO: find more appropriate place
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
    
    public var lineOrBranch: [String] {
        return self.lineOrBranchString.split(separator: "/").map({ String($0) })
    }
    let lineOrBranchString: String
    
    #if os(iOS)
    public func asUIColor() throws -> UIColor {
        return try UIColor(rgba_throws: self.rgbHex)
    }
//    #else
//    public func asNSColor() throws -> NSColor {
//        return try NSColor(rgba_throws: self.rgbHex)
//    }
    #endif
    public let rgbHex: String
    public let pantoneCVC: String
    public let cmyk: String
    
    enum CodingKeys : String, CodingKey {
        case modeString = "MTA Mode"
        case lineOrBranchString = "Line/Branch"
        case rgbHex = "RGB Hex"
        case pantoneCVC = "Pantone CVC"
        case cmyk = "CMYK"
    }
}
