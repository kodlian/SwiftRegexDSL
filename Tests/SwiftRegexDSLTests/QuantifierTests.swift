//
//  File.swift
//  
//
//  Created by Jeremy Marchand on 12/09/2020.
//

import XCTest
@testable import SwiftRegexDSL

final class QuantifierTests: XCTestCase {

    // MARK: - OneOrMore
    func testOneOrMoreWithZeroDigit() throws {
        let text = "foofoo"
        XCTAssertNil(text.range(of: Digit().oneOrMore()))
    }
    
    func testOneOrMoreWithOneDigit() throws {
        let text = "foo2foo"
        
        guard let range = text.range(of: Digit().oneOrMore()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(text[range], "2")
    }
    
    func testOneOrMoreWithTwoDigits() throws {
        let text = "foo21foo"
        
        guard let range = text.range(of: Digit().oneOrMore()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(text[range], "21")
    }
    
    // MARK: - ZeroOrMore
    func testZeroOrOneWithNoDigit() throws {
        let text = "foofoo"
        
        XCTAssertNotNil(text.range(of: Group {
            "foo"
            Digit().zeroOrMore()
            "foo"
        }))
    }
    
    func testOtZeroOrOneWithOneDigit() throws {
        let text = "foo1foo"
        
        XCTAssertNotNil(text.range(of: Group {
            "foo"
            Digit().zeroOrMore()
            "foo"
        }))
    }
    
    // MARK: - Exactly
    func testExactlyWithNotEnoughDigit() throws {
        let text = "foo111foo"
        XCTAssertNil(text.range(of: Digit().exactly(10)))
    }
    
    func testExactlyWithEnoughDigit() throws {
        let text = "foo111foo"
        guard let range = text.range(of: Digit().exactly(2)) else {
            XCTFail()
            return
        }
        XCTAssertEqual(text[range], "11")
    }
    
    // MARK: - Range
    func testClosedRangeWithNotEnoughDigit() throws {
        let text = "foo111foo"
        XCTAssertNil(text.range(of: Digit().quantified(4...7)))
    }
    
    func testClosedRangeWithEnoughDigit() throws {
        let text = "foo111foo"
        guard let range = text.range(of: Digit().quantified(1...4)) else {
            XCTFail()
            return
        }
        XCTAssertEqual(text[range], "111")
    }
    
    func testPartialFromRangeWithNotEnoughDigit() throws {
        let text = "foo111foo"
        XCTAssertNil(text.range(of: Digit().quantified(4...)))
    }
    
    func testPartialRangeFromWithEnoughDigit() throws {
        let text = "foo111foo"
        guard let range = text.range(of: Digit().quantified(1...)) else {
            XCTFail()
            return
        }
        XCTAssertEqual(text[range], "111")
    }
    
    
    // MARK: Lazy
    func testLazyOneOrMoreWithTwoDigits() throws {
        let text = "foo21foo"
        
        guard let range = text.range(of: Digit().oneOrMore().lazy()) else {
            XCTFail()
            return
        }
        XCTAssertEqual(text[range], "2")
    }
}



