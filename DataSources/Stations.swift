//
//  Stations.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

// TODO: support original CSVs

// Based on http://web.mta.info/developers/data/nyct/subway/Stations.csv
open class Stations: DataSource<Station> {
    public var stationsByDaytimeRoute: [DaytimeRoute: [Station]] {
        return self._stationsByDaytimeRoute
    }
    // TODO: devise a better way of organizing flow and hopefully not make optional, this is an antipattern
    private var _stationsByDaytimeRoute: [DaytimeRoute: [Station]] = [:]
    
    static func stationsByDaytimeRoute(_ stations: [Station]) -> [DaytimeRoute: [Station]] {
        var result: [DaytimeRoute: [Station]] = [:]
        for station in stations {
            for daytimeRoute in station.daytimeRoutes {
                var line: [Station]
                if let keyedLine = result[daytimeRoute] {
                    line = keyedLine
                } else {
                    line = []
                }
                line.append(station)
                result[daytimeRoute] = line
            }
        }
        return result
    }
    
    override func postValuesInitialized(values: [Station]) {
        super.postValuesInitialized(values: values)
        
        self._stationsByDaytimeRoute = Stations.stationsByDaytimeRoute(self.values)
    }
}
