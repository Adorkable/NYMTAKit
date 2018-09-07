//
//  DataSource.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

open class DataSource<Type> where Type: Decodable {
    public var values: [Type] {
        return self._values
    }
    private var _values: [Type]
    
    public init(json: Data) throws {
        do {
            let values = try JSONDecoder().decode([Type].self, from: json)
            self._values = values
        } catch {
            throw DecodeJSONDataError(context: "\(Type.self)", error: error)
        }
    }
    
    public convenience init(jsonDataAssetName assetName: String, bundle: Bundle) throws {
        guard  let asset = NSDataAsset(name: assetName, bundle: bundle) else {
            throw UnableToFindDataAssetError(dataAssetName: assetName)
        }
        
        try self.init(json: asset.data)
    }
}
