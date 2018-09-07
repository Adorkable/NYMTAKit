//
//  Complexes.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

// TODO: support original CSVs

// Based on http://web.mta.info/developers/data/nyct/subway/StationComplexes.csv
class Complexes {
    var complexes: [Complex] {
        return self._complexes
    }
    private var _complexes: [Complex]
    
    init(json: Data) throws {
        do {
            let complexes = try JSONDecoder().decode([Complex].self, from: json)
            self._complexes = complexes
        } catch {
            throw DecodeJSONDataError(context: "Complexes", error: error)
        }
    }
    
    convenience init(jsonDataAssetName assetName: String, bundle: Bundle) throws {
        guard  let asset = NSDataAsset(name: assetName, bundle: bundle) else {
            throw UnableToFindDataAssetError(dataAssetName: assetName)
        }
        
        try self.init(json: asset.data)
    }
}
