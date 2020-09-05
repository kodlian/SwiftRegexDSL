//
//  Regex.swift
//  
//
//

import Foundation

// MARK: - Regex
/// base Regular Expression protocol. The regex is built using other regex by composition in the body.
///    ```swift
///    struct MyRegex: Regex {
///      @RegexBuilder
///      var body: Regex {
///         Digit()
///           .oneOrMore()
///         Word()
///      }
///    }
///    ```
public protocol Regex {
    /// Body of the regex that is built it using regex.
    /// It is generally annotated with a `@RegexBuilder` property to apply the SwiftRegexDSL to the expression.
    var body: Regex { get }
    
    /// Applies a modifier to a regex and returns a new regex.
    func modifier(_ modifier: RegexModifier) -> Regex 
}

extension Regex {
    var rawRegex: String {
        if let reg = self as? UnsafeText {
            return reg.value
        } else {
            return body.rawRegex
        }
    }
}

public extension RawRepresentable where Self: Regex, RawValue == String {
    var regex: Regex {
        return UnsafeText(rawValue)
    }
}

public func +(leftRegex: Regex, rightRegex: Regex) -> UnsafeText {
    UnsafeText(leftRegex.rawRegex + rightRegex.rawRegex)
}

/// Delimited regex don't need a group before a modifier is applied.
public protocol DelimitedRegex: Regex {
    
}
