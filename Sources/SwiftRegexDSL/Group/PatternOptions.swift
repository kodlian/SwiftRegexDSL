//
//  PatternOptions.swift
//  
//
//  Created by Jeremy Marchand on 08/09/2020.
//

import Foundation

/// The following flags control various aspects of regular expression matching.
public struct PatternOptions: OptionSet, Hashable {
    
    /// If set, matching will take place in a case-insensitive manner.
    public static let caseInsensitive = PatternOptions(rawValue: 1 << 0)
    
    /// If set, allow use of white space and #comments within patterns
    public static var allowCommentsAndWhitespace = PatternOptions(rawValue: 1 << 1)
    
    /// If set, a AnyCharacter in a pattern will match a line terminator in the input text. By default, it will not. Note that a carriage-return / line-feed pair in text behave as a single line terminator, and will match a single "." in a regular expression pattern
    public static var dotMatchesLineSeparators = PatternOptions(rawValue: 1 << 2)
    
    /// Control the behavior of "^" and "$" in a pattern. By default these will only match at the start and end, respectively, of the input text. If this flag is set, "^" and "$" will also match at the start and end of each line within the input text.
    public static var anchorsMatchLines = PatternOptions(rawValue: 1 << 3)
    
    /// Controls the behavior of \b in a pattern. If set, word boundaries are found according to the definitions of word found in Unicode UAX 29, Text Boundaries. By default, word boundaries are identified by means of a simple classification of characters as either “word” or “non-word”, which approximates traditional regular expression behavior. The results obtained with the two options can be quite different in runs of spaces and other non-word characters.
    public static var useUnicodeWordBoundaries = PatternOptions(rawValue: 1 << 4)
    
    static let all: [PatternOptions: Character] = [
        .caseInsensitive : "i",
        .allowCommentsAndWhitespace : "x",
        .dotMatchesLineSeparators : "s",
        .anchorsMatchLines : "m",
        .useUnicodeWordBoundaries : "w"
    ]
    
    public let rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    var string: String {
        return Self.all.reduce(into: "") { result, flag in
            if self.contains(flag.key) {
                result.append(flag.value)
            }
        }
    }
}

/// Evaluate the included pattern with the specified options enabled or -disabled.
public struct OptionsModifier: RegexModifier {
    internal init(enabledOptions: PatternOptions = [], disabledOptions: PatternOptions = []) {
        self.enabledOptions = enabledOptions
        self.disabledOptions = disabledOptions
    }
    
    let enabledOptions: PatternOptions
    let disabledOptions: PatternOptions
    
    @RegexBuilder
    public func body(content: Regex) -> Regex {
        UnsafeText("(?")
        if !enabledOptions.isEmpty {
            enabledOptions.string
        }
        if !disabledOptions.isEmpty {
            "-"
            disabledOptions.string
        }
        UnsafeText(":")
        if let group = content as? Group {
            group.content
        } else {
            content
        }
        UnsafeText(")")
    }
}

public extension Regex {
    /// Apply pattern options on a regex
    func options(_ options: PatternOptions) -> Regex {
        return modifier(OptionsModifier(enabledOptions: options))
    }
    
    /// Disable pattern options on a regex
    func disabledOptions(_ options: PatternOptions) -> Regex {
        return modifier(OptionsModifier(disabledOptions: options))
    }
    
    /// Apply or disable pattern options on a regex
    func options(enabled enabledOptions: PatternOptions, disabled disabledOptions: PatternOptions) -> Regex {
        return modifier(OptionsModifier(enabledOptions: enabledOptions, disabledOptions: disabledOptions))
    }
    
    /// Make the regex case insensitive
    func caseInsensitive() -> Regex {
        return self.options(.caseInsensitive)
    }
}
