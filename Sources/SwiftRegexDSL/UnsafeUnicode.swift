//
//  UnsafeUnicode.swift
//  
//
//  Created by Jeremy Marchand on 11/09/2020.
//

import Foundation

/// Match unicode character. The pattern does not offer checked during compile time. as such it is unsafe.
public struct UnsafeUnicode: Regex {
    let pattern: String
    
    /// Match any character with the specified Unicode Property.
    public init(name: String) {
        self.pattern = #"\N{\#(name)}"#
    }
    
    /// Match any character with the specified Unicode Property.
    public init(property: String) {
        self.pattern = #"\p{\#(property)}"#
    }

    /// Match any character not having the specified Unicode Property.
    public init(notProperty: String) {
        self.pattern = #"\P{\#(notProperty)}"#
    }
    
    /// Match the character with the given value.
    public init(_ value: UInt32) {
        let hexString = String(format: "%02x", value)
        self.pattern = #"\x{\#(hexString)}"#
    }
    
    public var body: Regex {
        return UnsafeText(pattern)
    }
}
