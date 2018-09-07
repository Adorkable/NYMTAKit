//
//  Station.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import CoreLocation

struct Station: Decodable {
    let id: UInt
    let complexId: UInt
    let gtfsStopId: String
    
    let division: String
    
    let line: String
    
    var name: String
    
    let borough: String
    
    var daytimeRoutes: [DaytimeRoute] {
        return self.daytimeRoutesString.split(separator: " ").map({ (substring) -> String in
            return String(substring)
        })
    }
    let daytimeRoutesString: String
    let structure: String
    
    let gtfsLatitude: Double
    let gtfsLongitude: Double
    var location: CLLocation {
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
}
