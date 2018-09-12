//
//  Stop.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/12/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import GTFSKit

public extension Stop {
    public func stopTimes(_ stopTimes: [StopTime]) -> [StopTime] {
        return stopTimes.filter({ $0.stopId == self.id })
    }
}
