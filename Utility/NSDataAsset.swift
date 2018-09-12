//
//  NSDataAsset.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/12/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#else
import Cocoa
#endif

extension NSDataAsset {
#if os(macOS)
    convenience init?(name: String, bundle: Bundle) {
        let dataAssetName = NSDataAsset.Name(rawValue: name)
        self.init(name: dataAssetName, bundle: bundle)
    }
#endif
}
