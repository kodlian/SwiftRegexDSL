//
//  Quantifier.swift
//  
//
//  Created by Jeremy Marchand on 05/09/2020.
//

import Foundation

// MARK: Quantifier
/// Regex Quanti­fiers - Specify the number of occurrences of a pattern.
public enum Quantifier: RegexModifier {
    /// 0 or more
    case zeroOrMore
    /// 1 or more
    case oneOrMore
    /// 0 or 1
    case zeroOrOne
    /// Exactly n
    case exactly(UInt)
    /// Range
    case range(QuantityRange)

    var value: String {
        switch self {
            case .zeroOrMore:
                return "*"
            case .oneOrMore:
                return "+"
            case .zeroOrOne:
                return "?"
            case let .exactly(quantity):
                return "{\(quantity)}"
            case let .range(range):
                return range.quantifier
        }
    }
    
    public func body(content: Regex) -> Regex {
        return QuantifiedPattern(base: content, quantifier: self)
    }
}


// MARK: QuantifiedPattern
/// A pattern with an attributed quantifier
public struct QuantifiedPattern: Regex {
    let base: Regex
    let quantifier: Quantifier
    
    @RegexBuilder
    public var body: Regex {
        base
        UnsafeText(quantifier.value)
    }
    
    init(base: Regex, quantifier: Quantifier) {
        self.base = base is DelimitedRegex ? base : Group(content: base)
        self.quantifier = quantifier
    }
}

public extension QuantifiedPattern {
    /// By default quantifiers are greedy, meaning the quantifier will match as many as possible. To change this behaviour make a quantified pattern lazy.
    /// For instance, take the oneOrMore quantifier. It allows the engine to match one or more of the token it quantifies: \d+ can therefore match one or more digits. But "one or more" is rather vague: in the string 123, "one or more digits" (starting from the left) could be 1, 12 or 123. Which of these does \d+ match?
    @RegexBuilder
    func lazy() -> Regex {
        self
        UnsafeText("?")
    }
    
    @RegexBuilder
    func possesive() -> Regex {
        self
        UnsafeText("+")
    }
}

public extension Regex {
   
    /// Specify the number of occurrences of a pattern using a `Quantifier`.
    /// ```Swift
    /// Digit()
    ///   .quantified(0..<2)
    /// }
    /// ```
    func quantified(_ quantifier: Quantifier) -> QuantifiedPattern {
        return QuantifiedPattern(base: self, quantifier: quantifier)
    }
    
    /// 0 or more occurrence(s)
    func zeroOrMore() -> QuantifiedPattern {
        return quantified(.zeroOrMore)
    }
    
    /// 1 or more occurrence(s)
    func oneOrMore() -> QuantifiedPattern {
        return quantified(.oneOrMore)
    }
    
    /// 0 or 1 occurrence, making the pattern optional.
    func zeroOrOne() -> QuantifiedPattern {
        return quantified(.zeroOrOne)
    }
    
    /// Exactly n occurrences
    func exactly(_ n: UInt) -> QuantifiedPattern {
        return quantified(.exactly(n))
    }
    
    /// Specify by range the number of occurrence
    func quantified(_ range: QuantityRange) -> QuantifiedPattern {
        return quantified(.range(range))
    }
}

// MARK: Range
/// Range applicable to a quantifier
public protocol QuantityRange {
    var quantifierLowerdBound: UInt? { get }
    var quantifierUpperBound: UInt? { get }
}

extension QuantityRange {
    var quantifier: String {
        let lowerBound = quantifierLowerdBound.map(String.init) ?? ""
        let upperBound = quantifierUpperBound.map(String.init) ?? ""
        
        return "{\(lowerBound),\(upperBound)}"
    }
}

extension ClosedRange: QuantityRange where Element == UInt {
    public var quantifierLowerdBound: UInt? {
        return lowerBound
    }
    
    public var quantifierUpperBound: UInt? {
        return upperBound
    }
}

extension PartialRangeFrom: QuantityRange where Bound == UInt {
    public var quantifierLowerdBound: UInt? {
        return lowerBound
    }
    
    public var quantifierUpperBound: UInt? {
        return nil
    }
}
