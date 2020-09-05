//
//  Group.swift
//  
//
//  Created by Jeremy Marchand on 13/09/2020.
//

import Foundation

/// Non-capturing group. Groups the included pattern, but does not provide capturing of matching text. Somewhat more efficient than capturing group.
public struct Group: DelimitedRegex {
    let content: Regex
    public init(@RegexBuilder content: () -> Regex) {
        self.content =  content()
    }
    
    public init(content: Regex...) {
        self.content = content.joined()
    }
    
    public var body: Regex {
        return UnsafeText("(?:\(content.rawRegex))")
    }
}
