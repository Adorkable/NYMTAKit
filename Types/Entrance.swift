//
//  Entrance.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import CoreLocation
import GTFSKit

public struct Entrance: Decodable {
    public let division: String
    public let line: String

    public let stationName: String

    let stationLatitude: Double
    let stationLongitude: Double
    public var stationLocation: CLLocation {
        return CLLocation(latitude: self.stationLatitude, longitude: self.stationLongitude)
    }
    func station(stations: Stations) throws -> Station {
        let found = stations.values.filter { $0.gtfsLocation == self.stationLocation }
        guard found.count < 2 else {
            throw TooManyMatchesFoundError(context: "Station", for: Swift.type(of: self), matches: found)
        }
        
        guard let result = found.first else {
            throw NoMatchesFoundError(context: "Station", for: Swift.type(of: self))
        }
        
        return result
    }

    let route1: String?
    let route2: String?
    let route3: String?
    let route4: String?
    let route5: String?
    let route6: String?
    let route7: String?
    let route8: String?
    let route9: String?
    let route10: String?
    let route11: String?
    public var routes: [String] {
        return [
            self.route1,
            self.route2,
            self.route3,
            self.route4,
            self.route5,
            self.route6,
            self.route7,
            self.route8,
            self.route9,
            self.route10,
            self.route11
            ].compactMap { $0 }.filter { $0.count > 0}
    }
    
    let typeString: String
    public enum `Type`: CustomStringConvertible {
        case stair
        case elevator
        case door
        case easement
        
        init(from: String) throws {
            var found: Type?
            for mode in Type.all {
                if mode.description == from {
                    found = mode
                    break
                }
            }
            if let found = found {
                self = found
            } else {
                throw UnexpectedValueForTypeError(value: from, type: "Type", context: "Entrance")
            }
        }
        
        public static let all: [Type] = [
            .stair,
            .elevator,
            .door,
            .easement
        ]
        
        public var description: String {
            switch self {
            case .stair:
                return "Stair"
            case .elevator:
                return "Elevator"
            case .door:
                return "Door"
            case .easement:
                return "Easement"
            }
        }
    }
    public func type() throws -> Type {
        return try Type(from: self.typeString)
    }
    
    static func asBool(_ string: String) -> Bool {
        guard string.count > 0 else {
            return false
        }
        guard string.uppercased() == "YES" || string.uppercased() == "TRUE" else {
            return false
        }
        return true
    }
    let entryString: String
    public var entry: Bool {
        return Entrance.asBool(self.entryString)
    }
    
    let exitOnlyString: String
    public var exitOnly: Bool {
        return Entrance.asBool(self.exitOnlyString)
    }
    
    let vendingString: String
    public var vending: Bool {
        return Entrance.asBool(self.vendingString)
    }
    
    let staffingString: String
    public enum Staffing {
        case full
        case none
        
        init(from: String) throws {
            var found: Staffing?
            for mode in Staffing.all {
                if mode.description == from {
                    found = mode
                    break
                }
            }
            if let found = found {
                self = found
            } else {
                throw UnexpectedValueForTypeError(value: from, type: "Staffing", context: "Entrance")
            }
        }
        
        public static let all: [Staffing] = [
            .full,
            .none
        ]
        
        public var description: String {
            switch self {
            case .full:
                return "FULL"
            case .none:
                return "NONE"
            }
        }
    }
    public func staffing() throws -> Staffing {
        return try Staffing(from: self.staffingString)
    }
    
    public let staffHours: String // TODO: Time Range
    
    let adaString: String
    public var ada: Bool {
        return Entrance.asBool(self.adaString)
    }
    public let adaNotes: String
    
    let freeCrossoverString: String
    public var freeCrossover: Bool {
        return Entrance.asBool(self.freeCrossoverString)
    }
    
    public let northSouthStreet: String
    public let eastWestStreet: String
    public let corner: String

    let latitude: Double
    let longitude: Double
    public var location: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    enum CodingKeys : String, CodingKey {
        case division = "Division"
        case line = "Line"
        
        case stationName = "Station_Name"
        case stationLatitude = "Station_Latitude"
        case stationLongitude = "Station_Longitude"

        case route1 = "Route_1"
        case route2 = "Route_2"
        case route3 = "Route_3"
        case route4 = "Route_4"
        case route5 = "Route_5"
        case route6 = "Route_6"
        case route7 = "Route_7"
        case route8 = "Route_8"
        case route9 = "Route_9"
        case route10 = "Route_10"
        case route11 = "Route_11"
        
        case typeString = "Entrance_Type"
        
        case entryString = "Entry"
        case exitOnlyString = "Exit_Only"
        case vendingString = "Vending"
        case staffingString = "Staffing"
        case staffHours = "Staff_Hours"
        case adaString = "ADA"
        case adaNotes = "ADA_Notes"
        case freeCrossoverString = "Free_Crossover"
        case northSouthStreet = "North_South_Street"
        case eastWestStreet = "East_West_Street"
        
        case corner = "Corner"
        
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}
