//
//  Transfer.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/12/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import GTFSKit

extension Transfer {
    func fromStop(stops: [Stop]) -> Stop? {
        // TODO: test for 0 or greater than 1
        return stops.filter({ (stop) -> Bool in
            return stop.id == self.fromStopId
        }).first
    }

    func toStop(stops: [Stop]) -> Stop? {
        // TODO: test for 0 or greater than 1
        return stops.filter({ (stop) -> Bool in
            return stop.id == self.toStopId
        }).first
    }
}
