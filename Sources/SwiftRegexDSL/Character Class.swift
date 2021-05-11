//
//  Character Class.swift
//  
//
//  Created by Jeremy Marchand on 05/09/2020.
//

import Foundation


/// Match a control-X character
public struct Control: Regex {
    public let character: Character
    
    public init(character: Character) {
        self.character = character
    }
    
    public var body: Regex {
        return UnsafeText(#"\c\#(character)"#)
    }
}

/// Match any character with the Unicode General Category of Nd (Number, Decimal Digit.)
public struct Digit: StaticRegex {
    public init() { }
    
    public var body: Regex {
        return UnsafeText(#"\d"#)
    }
}

/// Match any character that is not a decimal digit.
public struct NotDigit: StaticRegex {
    public init() { }

    public var body: Regex {
        return UnsafeText(#"\D"#)
    }
}

/// Match a word character. Word characters are [\p{Ll}\p{Lu}\p{Lt}\p{Lo}\p{Nd}].
public struct Word: StaticRegex {
    public init() { }

    public var body: Regex {
        return UnsafeText(#"\w"#)
    }
}

/// Match a non-word character.
public struct NotWord: StaticRegex {
    public init() { }

    public var body: Regex {
        return UnsafeText(#"\W"#)
    }
}

/// Match a white space character. White space is defined as [\t\n\f\r\p{Z}].
public struct WhiteSpace: StaticRegex {
    public init() { }

    public var body: Regex {
        return UnsafeText(#"\s"#)
    }
}

/// Match a non-white space character.
public struct NotWhiteSpace: StaticRegex {
    public init() { }

    public var body: Regex {
        return UnsafeText(#"\S"#)
    }
}

/// Match any character.
public struct AnyCharacter: StaticRegex {
    public init() { }

    public var body: Regex {
        return UnsafeText(#"."#)
    }
}
