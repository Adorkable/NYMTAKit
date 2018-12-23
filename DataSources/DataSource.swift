//
//  DataSource.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import GTFSKit
import CSV
#if os(iOS)
import UIKit
#else
import Cocoa
#endif

/// Generic Data Source for parsing NYMTA data
open class DataSource<Type> where Type: Decodable {
    /// All values
    public var values: [Type] {
        return self._values
    }
    private var _values: [Type]


    /// Initialize from JSON data
    ///
    /// - Parameter json: JSON data
    /// - Throws: When unable to decode the JSON data
    public required init(json: Data) throws {
        let values: [Type]
        do {
            values = try JSONDecoder().decode([Type].self, from: json)
        } catch {
            throw DecodeJSONDataError(context: "\(Type.self)", error: error)
        }
        self._values = values

        self.postValuesInitialized(values: self._values)
    }
    
    /// Initialized from a JSON asset in the specified Bundle
    ///
    /// - Parameters:
    ///   - assetName: JSON asset name
    ///   - bundle: Bundle
    /// - Throws: When unable to find the data asset or unable to decode the JSON data
    public convenience init(jsonDataAssetName assetName: String, bundle: Bundle) throws {
        guard  let asset = NSDataAsset(name: assetName, bundle: bundle) else {
            throw UnableToFindDataAssetError(dataAssetName: assetName)
        }
        
        try self.init(json: asset.data)
    }
    
    /// Initialize from CSV string
    ///
    /// - Parameter csv: CSV string
    /// - Throws: When unable to decode the CSV data
    public required init(csv: String) throws {
        let reader = try CSVReader(string: csv, hasHeaderRow: true, trimFields: true)

        var values: [Type] = []
        while let value: Type = try reader.readRow() {
            values.append(value)
        }
        self._values = values
        
        self.postValuesInitialized(values: self._values)
    }
    
    /// Initialize from CSV data
    ///
    /// - Parameter csv: CSV data
    /// - Throws: When unable to decode the CSV data
    public convenience init(csv: Data) throws {
        guard let csvString = String(data: csv, encoding: .utf8) else {
            // TODO: throw
            throw UnableToFindDataAssetError(dataAssetName: "asldkfjalskdjfl")
        }
        
        try self.init(csv: csvString)
    }

    /// Initialize from a CSV asset in the specified Bundle
    ///
    /// - Parameters:
    ///   - assetName: CSV asset name
    ///   - bundle: Bundle
    /// - Throws: When unable to find the data asset or unable to decode the CSV data
    public convenience init(csvDataAssetName assetName: String, bundle: Bundle) throws {
        guard  let asset = NSDataAsset(name: assetName, bundle: bundle) else {
            throw UnableToFindDataAssetError(dataAssetName: assetName)
        }
        
        try self.init(csv: asset.data)
    }
    
    // TODO: use more performant parsed value closure on individual parse
    func postValuesInitialized(values: [Type]) {
    }
}
