//
//  Errors.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

/// Error while decoding JSON data
open class DecodeJSONDataError: Error {
    /// Context
    public let context: String
    /// Decode error
    public let error: Error
    /// Initialize with context description and decode error
    ///
    /// - Parameters:
    ///   - context: Context description
    ///   - error: Decode error
    public init(context: String, error: Error) {
        self.context = context
        self.error = error
    }

    /// Human readable description
    public var localizedDescription: String {
        return "Error while decoding \(self.context) JSON data: \(self.error.localizedDescription)"
    }
}

/// Unable to find an expected data asset
open class UnableToFindDataAssetError: Error {
    /// Data asset name
    public let dataAssetName: String
    /// Initialize with data asset name
    ///
    /// - Parameter dataAssetName: Data asset name
    public init(dataAssetName: String) {
        self.dataAssetName = dataAssetName
    }

    /// Human readable description
    public var localizedDescription: String {
        return "Unable to find data asset with name \(self.dataAssetName)"
    }
}

/// Encountered an unexpected value for a type in the specified context
open class UnexpectedValueForTypeError: Error {
    /// Unexpected value
    public let value: String
    /// Type
    public let type: String
    /// Context description
    public let context: String
    /// Initialize with unexpected value for type in context
    ///
    /// - Parameters:
    ///   - value: Unexpected value
    ///   - type: Type
    ///   - context: Context description
    public init(value: String, type: String, context: String) {
        self.value = value
        self.type = type
        self.context = context
    }
    
    /// Human readable description
    public var localizedDescription: String {
        return "Unexpected value '\(self.value)' for type '\(self.type)' in \(self.context)"
    }
}

