//
//  StopTime.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/12/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import GTFSKit

public extension StopTime {
    public func stop(stops: [Stop]) throws -> Stop {

        let found = stops.filter({ (stop) -> Bool in
            return stop.id == self.stopId
        })
        
        guard found.count < 2 else {
            throw TooManyMatchesFoundError(context: "StopTime::stop([Stop])", for: Stop.self, matches: found)
        }
        
        guard let result = found.first else {
            throw NoMatchesFoundError(context: "StopTime::stop([Stop])", for: Stop.self)
        }
        
        return result
    }
    
    public func trip(_ trips: [Trip]) throws -> Trip {
        
        let found = trips.filter({ (trip) -> Bool in
            return trip.id == self.tripId
        })
        
        guard found.count < 2 else {
            throw TooManyMatchesFoundError(context: "StopTime::trip([Trip])", for: Trip.self, matches: found)
        }
        
        guard let result = found.first else {
            throw NoMatchesFoundError(context: "StopTime::trip([Trip])", for: Trip.self)
        }
        
        return result
    }
    
    public static func sort(left: StopTime, right: StopTime) -> ComparisonResult {
        if left.stopSequence < right.stopSequence {
            return .orderedAscending
        } else if left.stopSequence == right.stopSequence {
            return .orderedSame
        } else {
            return .orderedDescending
        }
    }
}
