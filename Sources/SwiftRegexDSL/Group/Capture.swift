//
//  CapturingGroup.swift
//  
//
//  Created by Jeremy Marchand on 13/09/2020.
//

import Foundation

/// Capturing group. Range of input that matched the subexpression content is available after the match.
public struct CapturingGroup: DelimitedRegex {
    let content: Regex
    public init(@RegexBuilder content: () -> Regex) {
        self.content =  content()
    }
    
    public init(content: Regex...) {
        self.content = content.joined()
    }
    
    public var body: Regex {
        return UnsafeText("(\(content.rawRegex))")
    }
}
