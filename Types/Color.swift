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

/// Line or branch color information
public struct Color: Decodable {
    // TODO: find more appropriate place

    /// Enum type of line or branch
    public enum Mode: CustomStringConvertible {
        /// NYC Subway
        case nyctSubway
        /// Long Island Railroad
        case lirr
        /// Metro North
        case metroNorth
        /// Bridges and tunnels
        case bridgesAndTunnels
        /// Unknown
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

        /// All `Mode`s
        public static let all: [Mode] = [
            .nyctSubway,
            .lirr,
            .metroNorth,
            .bridgesAndTunnels,
            .unknown
        ]
        
        /// Human readable description
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

    /// Type of line or branch
    public var mode: Mode {
        guard let result = Mode(from: self.modeString) else {
            return .unknown
        }
        return result
    }
    /// Parsed type of line string
    let modeString: String

    /// Lines or branches for this Color
    public var lineOrBranch: [String] {
        return self.lineOrBranchString.split(separator: "/").map({ String($0) })
    }
    /// Parsed lines or branches for this Color
    let lineOrBranchString: String
    
    #if os(iOS)
    /// as UIColor
    ///
    /// - Returns: Color value as a `UIColor`
    /// - Throws: If RGBHex format is invalid
    public func asUIColor() throws -> UIColor {
        return try UIColor(rgba_throws: self.rgbHex)
    }
//    #else
//    public func asNSColor() throws -> NSColor {
//        return try NSColor(rgba_throws: self.rgbHex)
//    }
    #endif
    /// RGB Hex value
    public let rgbHex: String
    /// Pantone CVC value
    public let pantoneCVC: String
    /// CMYK value
    public let cmyk: String
    
    enum CodingKeys : String, CodingKey {
        case modeString = "MTA Mode"
        case lineOrBranchString = "Line/Branch"
        case rgbHex = "RGB Hex"
        case pantoneCVC = "Pantone CVC"
        case cmyk = "CMYK"
    }
}
