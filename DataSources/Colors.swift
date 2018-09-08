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
    public var colorsByMode: [Color.Mode: [Color]] {
        return self._colorsByMode
    }
    // TODO: devise a better way of organizing flow and hopefully not make optional, this is an antipattern
    private var _colorsByMode: [Color.Mode: [Color]] = [:]
    
    static func colorsByMode(_ colors: [Color]) -> [Color.Mode: [Color]] {
        var result: [Color.Mode: [Color]] = [:]
        for color in colors {
            var list: [Color] = []
            if let previous = result[color.mode] {
                list = previous
            }
            list.append(color)
            result[color.mode] = list
        }
        return result
    }
    
    public var colorByLineOrBranch: [String: Color] {
        return self._colorByLineOrBranch
    }
    // TODO: devise a better way of organizing flow and hopefully not make optional, this is an antipattern
    private var _colorByLineOrBranch: [String: Color] = [:]
    
    static func colorByLineOrBranch(_ colors: [Color]) -> [String: Color] {
        var result: [String: Color] = [:]
        for color in colors {
            for line in color.lineOrBranch {
                result[line] = color
            }
        }
        return result
    }

    override func postValuesInitialized(values: [Color]) {
        super.postValuesInitialized(values: values)

        self._colorsByMode = Colors.colorsByMode(values)
        self._colorByLineOrBranch = Colors.colorByLineOrBranch(values)
    }
}

