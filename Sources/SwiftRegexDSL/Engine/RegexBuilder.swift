//
//  RegexBuilder.swift
//  
//
//  Created by Jeremy Marchand on 05/09/2020.
//

import Foundation

@_functionBuilder
public struct RegexBuilder {
    public static func buildBlock(_ partialResults: Regex...) -> Regex {
        return partialResults.joined()
    }
   
    // MARK: - Control Flow
    public static func buildDo(_ parts: Regex...) -> Regex {
        return parts.joined()
    }
    
    public static func buildIf(_ parts: Regex...) -> Regex {
        return parts.joined()
    }
    
    public static func buildEither(first: Regex...) -> Regex {
        return first.joined()
    }
    
    public static func buildEither(second: Regex...) -> Regex {
        return second.joined()
    }
    
    public static func buildOptional(_ optional: Regex?...) -> Regex {
        return optional.compactMap { $0 }.joined()
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
