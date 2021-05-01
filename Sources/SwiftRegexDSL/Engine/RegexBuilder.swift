//
//  RegexBuilder.swift
//  
//
//  Created by Jeremy Marchand on 05/09/2020.
//

import Foundation

@resultBuilder
public struct RegexBuilder {
    public static func buildBlock(_ partialResults: Regex...) -> Regex {
        return partialResults.joined()
    }

    public static func buildOptional(_ optional: Regex?) -> Regex {
        return UnsafeText(optional?.rawRegex)
    }

    public static func buildArray(_ components: [Regex]) -> Regex {
        return components.joined()
    }

    // MARK: - Control Flow
    public static func buildEither(first: Regex) -> Regex {
        return first
    }
    
    public static func buildEither(second: Regex) -> Regex {
        return second
    }

    public static func buildLimitedAvailability(_ component: Regex) -> Regex {
        return component
    }

    // MARK: - Expression
    public static func buildExpression(_ regex: Regex) -> Regex {
        return regex
    }

    public static func buildExpression(_ regex: Regex?) -> Regex {
        return buildOptional(regex)
    }
    
    public static func buildExpression(_ string: String) -> Regex {
        return Text(string)
    }
    
    public static func buildExpression<T: RawRepresentable>(_ rawRepresentable: T) -> Regex where T.RawValue == String {
        return Text(rawRepresentable.rawValue)
    }
    
    public static func buildExpression(_ integer: IntegerLiteralType) -> Regex {
        return Text(String(integer))
    }
    
    public static func buildExpression(_ number: FloatLiteralType) -> Regex {
        return Text(String(number))
    }
}
