//
//  Text.swift
//  
//
//  Created by Jeremy Marchand on 05/09/2020.
//

import Foundation

/// Baisc text content escaped to avoid to collide with regex pattern.
public struct Text: Regex {
    let text: String
    public init(_ text: String) {
        self.text = NSRegularExpression.escapedPattern(for: text)
    }
    
    public var body: Regex {
        UnsafeText(text)
    }
}
