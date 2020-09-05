//
//  UnsafeText.swift
//  
//
//  Created by Jeremy Marchand on 05/09/2020.
//

import Foundation

/// Use string as it is in the regular expression. This is unsafe as Regex may fails if content contains invalid regex.
public struct UnsafeText: Regex, ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    public let value: String
    public var body: Regex {
        self
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public extension Collection where Element == Regex {
    func joined(separator: String = "") -> UnsafeText {
        return UnsafeText(self.map { $0.rawRegex }.joined(separator: separator))
    }
}
