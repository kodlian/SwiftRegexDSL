//
//  Alternative.swift
//  
//
//  Created by Jeremy Marchand on 06/09/2020.
//

import Foundation

/// Alternation. A|B matches either A or B.
///    ```swift
///    struct DigitOrWhitespace: Regex {
///      var body: Regex {
///         Alternative {
///            Digit()
///            Whitespace()
///         }
///      }
///    }
///    ```
public struct Alternative: DelimitedRegex {
    let content: Regex
    
    public init(@AlternativeRegexBuilder content: () -> Regex) {
        self.content = content()
    }
    
    public init(content: Regex...) {
        self.content = content.joined(separator: "|")
    }
  
    public var body: Regex {
        return Group(content: content)
    }
}
