//
//  UIColor.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/7/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import UIKit

extension UIColor {
    static func createFrom(name: String, fallback: UIColor) -> UIColor {
        guard #available(iOS 11.0, *) else {
            return fallback
        }
        guard let named = UIColor(named: name) else {
            return fallback
        }
        return named
    }
}

// Based on: https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0)
    }
    
    // TODO: Support alpha
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
    
    class InvalidHexColorFormatError: Error {
        let invalidValue: String
        init(invalidValue: String) {
            self.invalidValue = invalidValue
        }
        var localizedDescription: String {
            return "Invalid hex color format value '\(self.invalidValue)'"
        }
    }
    convenience init(hex: String) throws {
        var string: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }
        
        // TODO: Support with alpha
        if string.count != 6 {
            throw InvalidHexColorFormatError(invalidValue: string)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: string).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

