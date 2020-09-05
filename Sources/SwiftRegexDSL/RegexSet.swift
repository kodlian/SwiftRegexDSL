//
//  RegexSet.swift
//  
//
//  Created by Jeremy Marchand on 06/09/2020.
//

import Foundation

/// Base protocol for component of regex range.
public protocol RegexSetComponent {
    var regexSetRepresentation: String { get }
}

public extension RegexSetComponent where Self: Regex {
    var body: Regex {
        return UnsafeText("[\((regexSetRepresentation))]")
    }
}

extension ClosedRange: RegexSetComponent, Regex where Bound == Character {
    public var regexSetRepresentation: String {
        return "\(lowerBound)-\(upperBound)"
    }
}

extension Character: RegexSetComponent {
    public var regexSetRepresentation: String {
        return NSRegularExpression.escapedPattern(for: String(self))
    }
}

extension Collection where Self: RegexSetComponent, Element == RegexSetComponent {
    public var regexSetRepresentation: String {
        return map { $0.regexSetRepresentation }.joined()
    }
}

extension Collection where Self: RegexSetComponent, Element: RegexSetComponent {
    public var regexSetRepresentation: String {
        return map { $0.regexSetRepresentation }.joined()
    }
}

extension Array: RegexSetComponent, Regex where Element == RegexSetComponent { }
extension Set: RegexSetComponent, Regex where Element: RegexSetComponent & Hashable & Equatable { }

/// Create an exclusion set.
public struct ExclusionSet: Regex {
    let content: RegexSetComponent
  
    public init(_ content: RegexSetComponent) {
        self.content = content
    }
    
    public init(_ content: RegexSetComponent...) {
        self.content = Array(content)
    }
    
    public var body: Regex {
        return UnsafeText("[^\((content.regexSetRepresentation))]")
    }
}
