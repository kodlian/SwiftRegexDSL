//
//  AlternativeRegexBuilder.swift
//  
//
//  Created by Jeremy Marchand on 06/09/2020.
//

import Foundation

@resultBuilder
public struct AlternativeRegexBuilder {
    public static func buildBlock(_ partialResults: Regex...) -> Regex {
        return partialResults.joined(separator: "|")
    }

    public static func buildOptional(_ optional: Regex?) -> Regex {
        return RegexBuilder.buildOptional(optional)
    }

    public static func buildArray(_ components: [Regex]) -> Regex {
        return components.joined(separator: "|")
    }

    // MARK: - Control Flow
    public static func buildEither(first: Regex) -> Regex {
        return RegexBuilder.buildEither(first: first)
    }
    
    public static func buildEither(second: Regex) -> Regex {
        return RegexBuilder.buildEither(second: second)
    }

    // MARK: - Expression
    public static func buildExpression(_ regex: Regex) -> Regex {
        return RegexBuilder.buildExpression(regex)
    }

    public static func buildExpression(_ regex: Regex?) -> Regex {
        return buildOptional(regex)
    }

    public static func buildExpression(_ string: String) -> Regex {
        return RegexBuilder.buildExpression(string)
    }
    
    public static func buildExpression<T: RawRepresentable>(_ rawRepresentable: T) -> Regex where T.RawValue == String {
        return RegexBuilder.buildExpression(rawRepresentable)
    }
    
    public static func buildExpression(_ integer: IntegerLiteralType) -> Regex {
        return RegexBuilder.buildExpression(integer)
    }
    
    public static func buildExpression(_ number: FloatLiteralType) -> Regex {
        return RegexBuilder.buildExpression(number)
    }
}
