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
    
    // MARK: - Control Flow
    public static func buildDo(_ parts: Regex...) -> Regex {
        return parts.joined(separator: "|")
    }
    
    public static func buildIf(_ parts: Regex...) -> Regex {
        return parts.joined(separator: "|")
    }
    
    public static func buildEither(first: Regex...) -> Regex {
        return first.joined(separator: "|")
    }
    
    public static func buildEither(second: Regex...) -> Regex {
        return second.joined(separator: "|")
    }
    
    public static func buildOptional(_ optional: Regex?...) -> Regex {
        return optional.compactMap { $0 }.joined(separator: "|")
    }
  
    // MARK: - Expression
    public static func buildExpression(_ regex: Regex) -> Regex {
        return regex
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
