//
//  Array.swift
//  GTFSKit
//
//  Created by Ian Grossberg on 9/13/18.
//  Copyright © 2018 Jack Wilsdon. All rights reserved.
//

import Foundation

extension Array {
    /// No matches found
    open class NoMatchesFoundError: Error {
    }
    
    /// Too many matches found when expecting one
    open class TooManyMatchesFoundError: Error {
    }
    
    /// Filter expecting only one remaining
    ///
    /// - Parameter isIncluded: Filter closure
    /// - Returns: The solitary match
    /// - Throws: When either 0 or more than 1 matches were found
    func filterOne(_ isIncluded: (Element) throws -> Bool) throws -> Element {
        let found = try self.filter(isIncluded)
        
        guard found.count < 2 else {
            throw TooManyMatchesFoundError()
        }
        
        guard let result = found.first else {
            throw NoMatchesFoundError()
        }
        
        return result
    }
}
