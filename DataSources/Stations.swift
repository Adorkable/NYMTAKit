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
class Stations {
    var stations: [Station] {
        return self._stations
    }
    private var _stations: [Station]
    
    var stationsByDaytimeRoute: [DaytimeRoute: [Station]] {
        return self._stationsByDaytimeRoute
    }
    private var _stationsByDaytimeRoute: [DaytimeRoute: [Station]]
    
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
    
    init(json: Data) throws {
        do {
            let stations = try JSONDecoder().decode([Station].self, from: json)
            self._stations = stations
            self._stationsByDaytimeRoute = Stations.stationsByDaytimeRoute(stations)
        } catch {
            throw DecodeJSONDataError(context: "Stations", error: error)
        }
    }
    
    convenience init(jsonDataAssetName assetName: String, bundle: Bundle) throws {
        guard  let asset = NSDataAsset(name: assetName, bundle: bundle) else {
            throw UnableToFindDataAssetError(dataAssetName: assetName)
        }
        
        try self.init(json: asset.data)
    }
}
