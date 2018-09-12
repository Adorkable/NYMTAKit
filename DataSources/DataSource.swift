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

open class DataSource<Type> where Type: Decodable {
    public var values: [Type] {
        return self._values
    }
    private var _values: [Type]
    
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
    
    public convenience init(jsonDataAssetName assetName: String, bundle: Bundle) throws {
        guard  let asset = NSDataAsset(name: assetName, bundle: bundle) else {
            throw UnableToFindDataAssetError(dataAssetName: assetName)
        }
        
        try self.init(json: asset.data)
    }
    
    public required init(csv: String) throws {
        let reader = try CSVReader(string: csv, hasHeaderRow: true, trimFields: true)

        var values: [Type] = []
        while let value: Type = try reader.readRow() {
            values.append(value)
        }
        self._values = values
        
        self.postValuesInitialized(values: self._values)
    }
    
    public convenience init(csv: Data) throws {
        guard let csvString = String(data: csv, encoding: .utf8) else {
            // TODO: throw
            throw UnableToFindDataAssetError(dataAssetName: "asldkfjalskdjfl")
        }
        
        try self.init(csv: csvString)
    }
    
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
