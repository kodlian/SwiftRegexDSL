//
//  RegexModifier.swift
//  
//
//  Created by Jeremy Marchand on 16/10/2020.
//

import Foundation

/// A modifier that you apply to a regex  or another regex modifier, producing a different version of the original value.
public protocol RegexModifier {
    @RegexBuilder
    func body(content: Regex) -> Regex
}

public extension Regex {
    /// Applies a modifier to a regex and returns a new regex.
    func modifier(_ modifier: RegexModifier) -> Regex {
        return modifier.body(content: self)
    }
}

public extension RegexModifier {
    /// Applies a modifier to a regex modifier and returns a new regex modifier.
    func modifier(_ modifier: RegexModifier) -> RegexModifier {
        return RegexModifierComposition(modifier1: self, modifier2: modifier)
    }
}

struct RegexModifierComposition: RegexModifier {
    let modifier1: RegexModifier
    let modifier2: RegexModifier

    public func body(content: Regex) -> Regex {
        modifier2.body(content: modifier1.body(content: content))
    }
}
