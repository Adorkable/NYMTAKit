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
open class Colors: DataSource<Color> {
    var colorByLineOrBranch: [String: Color] {
        return self._colorByLineOrBranch
    }
    private var _colorByLineOrBranch: [String: Color]
    
    static func colorByLineOrBranch(_ colors: [Color]) -> [String: Color] {
        var result: [String: Color] = [:]
        for color in colors {
            for line in color.lineOrBranch {
                result[line] = color
            }
        }
        return result
    }

    public override init(json: Data) throws {
        self._colorByLineOrBranch = [:] // TODO: devise a better way of organizing flow, this is an antipattern
 
        try super.init(json: json)
        
        self._colorByLineOrBranch = Colors.colorByLineOrBranch(self.values)
    }
}

