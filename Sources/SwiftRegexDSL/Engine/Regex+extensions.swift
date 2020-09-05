//
//  Regex+extensions.swift
//  
//
//  Created by Jeremy Marchand on 11/09/2020.
//

import Foundation

// MARK: - NSRegularExpression
public extension NSRegularExpression {
    convenience init(_ regex: Regex) throws {
        try self.init(pattern: regex.rawRegex, options: [])
    }
}

// MARK: - Ranges
public extension StringProtocol {
    func range(of regex: Regex, range: Swift.Range<Self.Index>? = nil, locale: Locale? = nil) -> Swift.Range<Self.Index>?  {
        return self.range(of: regex.rawRegex, options: .regularExpression, range: range, locale: locale)
    }
    
    func ranges(of regex: Regex, range: Swift.Range<Self.Index>? = nil) -> [Swift.Range<Self.Index>]  {
        let nsRange = NSRange(range ?? self.startIndex..<self.endIndex, in: self)
        
        guard let expression = try? NSRegularExpression(pattern: regex.rawRegex, options: []) else {
            return []
        }
        let ranges = expression
            .matches(in: String(self), options: [], range: nsRange)
            .compactMap { Swift.Range($0.range, in: self) }
    
        return ranges
    }
}

// MARK: - Groups
public extension StringProtocol {
    func capturedGroupsRanges(of regex: Regex, range: Swift.Range<Self.Index>? = nil) -> [[Swift.Range<String.Index>]] {
        guard let expression = try? NSRegularExpression(pattern: regex.rawRegex, options: []) else {
            return []
        }
        let nsRange = NSRange(range ?? self.startIndex..<self.endIndex, in: self)

        let groupMatches = expression
            .matches(in: String(self), options: [], range: nsRange)
            .compactMap { result -> [Swift.Range<String.Index>]? in
                guard result.numberOfRanges > 1 else {
                    return nil
                }
                var ranges = [Swift.Range<String.Index>]()
                for i in 0..<result.numberOfRanges {
                    guard let range = Swift.Range(result.range(at: i), in: self) else {
                        continue
                    }
                    ranges.append(range)
                }
                
                return ranges
            }
        
        return groupMatches
    }
}

// MARK: - Match
public extension StringProtocol {
    func match(_ regex: Regex, range: Swift.Range<Self.Index>? = nil, locale: Locale? = nil) -> Bool {
        return self.range(of: regex, range: range, locale: locale) != nil
    }
}

// MARK: - Replace
public extension StringProtocol {
    func replacingOccurrences(of regex: Regex, with replacingText: Self, range:  Swift.Range<Self.Index>? = nil) -> String {
        return replacingOccurrences(of: regex.rawRegex, with: replacingText, options: .regularExpression, range: range)
    }
}
