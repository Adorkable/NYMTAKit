//
//  Route.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/12/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import GTFSKit

public extension Route {
    public func trips(_ trips: [Trip]) -> [Trip] {
        return trips.filter( { $0.routeId == self.id })
    }
    
    public func trips(_ trips: [Trip], inDirection direction: Direction) -> [Trip] {
        return self.trips(trips).filter({ (test) -> Bool in
            guard let testDirection = test.direction else {
                return false
            }
            return testDirection == direction
        })
    }
}
