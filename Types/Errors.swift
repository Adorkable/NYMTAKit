//
//  Errors.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

open class DecodeJSONDataError: Error {
    public let context: String
    public let error: Error
    public init(context: String, error: Error) {
        self.context = context
        self.error = error
    }
    public var localizedDescription: String {
        return "Error while decoding \(self.context) JSON data: \(self.error.localizedDescription)"
    }
}

open class UnableToFindDataAssetError: Error {
    public let dataAssetName: String
    public init(dataAssetName: String) {
        self.dataAssetName = dataAssetName
    }
    public var localizedDescription: String {
        return "Unable to find data asset with name \(self.dataAssetName)"
    }
}

open class UnexpectedValueForTypeError: Error {
    public let value: String
    public let type: String
    public let context: String
    public init(value: String, type: String, context: String) {
        self.value = value
        self.type = type
        self.context = context
    }
    
    public var localizedDescription: String {
        return "Unexpected value '\(self.value)' for type '\(self.type)' in \(self.context)"
    }
}

