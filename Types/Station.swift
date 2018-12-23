//
//  Station.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import CoreLocation
import GTFSKit

/// Station
public struct Station: Decodable {
    /// ID
    public let id: UInt
    /// ID of complex
    public let complexId: UInt
    func complex(complexes: Complexes) -> Complex? {
        var found: Complex? = nil
        for test in complexes.values {
            if test.id == self.complexId {
                found = test
                break
            }
        }
        return found
    }

    /// Associated GTFS Stop ID
    public let gtfsStopId: String
    
    /// Division
    public let division: String
    
    /// Line or branch
    public let line: String
    
    /// Name
    public var name: String
    
    /// Borough
    public let borough: String
    
    /// Daytime routes
    public var daytimeRoutes: [DaytimeRoute] {
        return self.daytimeRoutesString.split(separator: " ").map({ (substring) -> String in
            return String(substring)
        })
    }
    let daytimeRoutesString: String

    /// Structure
    public let structure: String
    
    let gtfsLatitude: Double
    let gtfsLongitude: Double
    /// Location
    public var gtfsLocation: CLLocation {
        return CLLocation(latitude: self.gtfsLatitude, longitude: self.gtfsLongitude)
    }
    
    enum CodingKeys : String, CodingKey {
        case id = "Station ID"
        case complexId = "Complex ID"
        case gtfsStopId = "GTFS Stop ID"
        
        case division = "Division"
        
        case line = "Line"
        
        case name = "Stop Name"
        
        case borough = "Borough"
        
        case daytimeRoutesString = "Daytime Routes"
        
        case structure = "Structure"
        
        case gtfsLatitude = "GTFS Latitude"
        case gtfsLongitude = "GTFS Longitude"
    }
    
    func entrances(entrances: Entrances) -> [Entrance] {
        // Station name is not consistent between data sources, we're using station location for now
        return entrances.values.filter { $0.stationLocation == self.gtfsLocation }
    }
}

