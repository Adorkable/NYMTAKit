//
//  Trip.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/12/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import GTFSKit

public extension Trip {
    public func stopTimes(_ stopTimes: [StopTime]) -> [StopTime] {
        return stopTimes.filter( { $0.tripId == self.id })
    }
    
    public func route(_ routes: [Route]) throws -> Route {
        
        let found = routes.filter({ (route) -> Bool in
            return route.id == self.routeId
        })
        
        guard found.count < 2 else {
            throw TooManyMatchesFoundError(context: "Trip::route([Route])", for: Route.self, matches: found)
        }
        
        guard let result = found.first else {
            throw NoMatchesFoundError(context: "Trip::route([Route])", for: Route.self)
        }
        
        return result
    }
}
