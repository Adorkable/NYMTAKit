//
//  Shared.swift
//  NYMTAKitTests
//
//  Created by Ian Grossberg on 9/8/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import XCTest
import NYMTAKit
import GTFSKit

func data(bundle: Bundle, forResource fileName: String, withExtension: String) -> Data? {
    guard let url = bundle.url(forResource: fileName, withExtension: withExtension) else {
        XCTFail("Unable to find color data file '\(fileName)'")
        return nil
    }
    let data: Data
    do {
        data = try Data(contentsOf: url)
    } catch {
        XCTFail("Reading contents of URL \(url) threw error: \(error)")
        return nil
    }
    return data
}

func createFromCSV<Type, DataSourceType>(bundle: Bundle, forResource fileName: String, withExtension: String) -> Type? where Type: DataSource<DataSourceType>, DataSourceType: Decodable {
    
    guard let data = data(bundle: bundle, forResource: fileName, withExtension: withExtension) else {
        return nil
    }
    guard let string = String(data: data, encoding: .utf8) else {
        XCTFail("Unable to convert data '\(data)' into String from '\(fileName)'")
        return nil
    }
    let result: Type
    do {
        result = try Type(csv: string)
    } catch {
        XCTFail("Initializing \(Type.self) with data threw error: \(error)")
        return nil
    }
    return result
}
