//
//  Anchor.swift
//  
//
//  Created by Jeremy Marchand on 05/09/2020.
//

import Foundation

/// Anchor to match a particular area's beginning of the input
public enum StartAnchor: String, Regex {
    /// Start of string, or start of line in multi-line pattern
    case line = "^"
    /// Start of string
    case string = #"\A"#
    /// Start of word
    case word = #"\<"#
//    ///  Word boundary
//    case word = #"\b"#
    /// Not word boundary
    case notWord = #"\B"#
    
    public var body: Regex {
        UnsafeText(rawValue)
    }
}

/// Anchor to match a particular area's ending of the input
public enum EndAnchor: String, Regex {
    ///  End of string, or end of line in multi-line pattern
    case line = #"$"#
    ///  End of string
    case string = #"\Z"#
    /// End of word
    case word = #"\>"#
//    ///  Word boundary
//    case word = #"\b"#
    /// Not word boundary
    case notWord = #"\B"#
    
    public var body: Regex {
        UnsafeText(rawValue)
    }
}
