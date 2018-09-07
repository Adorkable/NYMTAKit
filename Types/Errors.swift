//
//  Errors.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation

class DecodeJSONDataError: Error {
    let context: String
    let error: Error
    init(context: String, error: Error) {
        self.context = context
        self.error = error
    }
    var localizedDescription: String {
        return "Error while decoding \(self.context) JSON data: \(self.error.localizedDescription)"
    }
}

class UnableToFindDataAssetError: Error {
    let dataAssetName: String
    init(dataAssetName: String) {
        self.dataAssetName = dataAssetName
    }
    var localizedDescription: String {
        return "Unable to find data asset with name \(self.dataAssetName)"
    }
}
