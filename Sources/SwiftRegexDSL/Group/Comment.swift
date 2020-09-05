//
//  Comment.swift
//  
//
//  Created by Jeremy Marchand on 13/09/2020.
//

import Foundation

/// Free-format comment (?# comment ).
public struct Comment: Regex {
    public init(_ text: String) {
        self.text = text
    }
    
    let text: String
    
    public var body: Regex {
        return UnsafeText("(?#\(text))")
    }
}
