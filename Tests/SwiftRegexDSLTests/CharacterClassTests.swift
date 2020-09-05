//
//  File.swift
//  
//
//  Created by Jeremy Marchand on 11/09/2020.
//

import XCTest
@testable import SwiftRegexDSL

final class CharacterClassTests: XCTestCase {

    func testDigit() {
        let text = "foo2foo"
        let range = text.range(of: Digit())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 3))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 4))
    }
    
    func testNotDigit() {
        let text = "1234r123"
        let range = text.range(of: NotDigit())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 4))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 5))
    }
    
    func testWord() {
        let text = "\n foo \n\n"
        let range = text.range(of: Word())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 2))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 3))
    }
    
    func testNotWord() {
        let text = "foo \n\n"
        let range = text.range(of: NotWord())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 3))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 4))
    }
    
    func testWhitespace() {
        let text = "123 23"
        let range = text.range(of: WhiteSpace())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 3))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 4))
    }
    
    func testNotWhiteSpace() {
        let text = "  123"
        let range = text.range(of: NotWhiteSpace())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 2))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 3))
    }
}



