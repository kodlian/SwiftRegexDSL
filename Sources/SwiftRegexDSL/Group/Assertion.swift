//
//  Assertion.swift
//  
//
//  Created by Jeremy Marchand on 13/09/2020.
//

import Foundation

/// Look-ahead assertion. True if the pattern matches at the current input position, but does not advance the input position.
public struct LookAheadAssertion: Regex {
    let content: Regex
    public init(@RegexBuilder content: () -> Regex) {
        self.content =  content()
    }
    
    public init(content: Regex...) {
        self.content = content.joined()
    }
    
    public var body: Regex {
        return UnsafeText("(?=\(content.rawRegex))")
    }
}

/// Negative look-ahead assertion. True if the pattern does not match at the current input position. Does not advance the input position.
public struct NegativeLookAheadAssertion: Regex {
    let content: Regex
    public init(@RegexBuilder content: () -> Regex) {
        self.content =  content()
    }
    
    public init(content: Regex...) {
        self.content = content.joined()
    }
    
    public var body: Regex {
        return UnsafeText("(?!\(content.rawRegex))")
    }
}

/// Look-behind assertion. True if the parenthesized pattern matches text preceding the current input position, with the last character of the match being the input character just before the current position. Does not alter the input position. The length of possible strings matched by the look-behind pattern must not be unbounded (no quantifierrs zero or more, or one and more.)
public struct LookBehindAssertion: Regex {
    let content: Regex
    public init(@RegexBuilder content: () -> Regex) {
        self.content =  content()
    }
    
    public init(content: Regex...) {
        self.content = content.joined()
    }
    
    public var body: Regex {
        return UnsafeText("(?<=\(content.rawRegex))")
    }
}

/// Negative Look-behind assertion. True if the parenthesized pattern does not match text preceding the current input position, with the last character of the match being the input character just before the current position. Does not alter the input position. The length of possible strings matched by the look-behind pattern must not be unbounded (no quantifierrs zero or more, or one and more.)
public struct NegativeLookBehindAssertion: Regex {
    let content: Regex
    public init(@RegexBuilder content: () -> Regex) {
        self.content =  content()
    }
    
    public init(content: Regex...) {
        self.content = content.joined()
    }
    
    public var body: Regex {
        return UnsafeText("(?<!\(content.rawRegex))")
    }
}
