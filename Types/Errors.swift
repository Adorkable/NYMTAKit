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
