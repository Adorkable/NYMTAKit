//
//  Colors.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

// TODO: support original CSVs

// Based on http://web.mta.info/developers/data/colors.csv
class Colors {
    var colorByLineOrBranch: [String: Color] {
        return self._colorByLineOrBranch
    }
    private var _colorByLineOrBranch: [String: Color]
    
    init(json: Data) throws {
        do {
            let colors = try JSONDecoder().decode([Color].self, from: json)
            
            var colorByLineOrBranch: [String: Color] = [:]
            for color in colors {
                for line in color.lineOrBranch {
                    colorByLineOrBranch[line] = color
                }
            }
            
            self._colorByLineOrBranch = colorByLineOrBranch
        } catch {
            throw DecodeJSONDataError(context: "Colors", error: error)
        }
    }
    
    convenience init(jsonDataAssetName assetName: String, bundle: Bundle) throws {
        guard  let asset = NSDataAsset(name: assetName, bundle: bundle) else {
            throw UnableToFindDataAssetError(dataAssetName: assetName)
        }

        try self.init(json: asset.data)
    }
}
