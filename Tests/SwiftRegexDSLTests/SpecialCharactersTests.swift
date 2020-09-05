//
//  File.swift
//  
//
//  Created by Jeremy Marchand on 09/09/2020.
//

import XCTest
@testable import SwiftRegexDSL


final class SpecialCharactersTests: XCTestCase {
    func testBell() {
        let text = "foo\u{0007}foo"
        let range = text.range(of: Bell())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 3))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 4))
    }
   
    func testEscape() {
        let text = "1\u{001B}123"
        let range = text.range(of: Escape())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 1))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 2))
    }
    
    func testForm() {
        let text = "1\u{000C}123"
        let range = text.range(of: Form())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 1))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 2))
    }
    
    func testLine() {
        let text = """
        1
        foo
        """
        let range = text.range(of: Line())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 1))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 2))
    }
    
    func testCarriageReturn() {
        let text = "abc\ra"
        let range = text.range(of: CarriageReturn())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 3))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 4))
    }
    
    func testTab() {
        let text = "ab\t"
        let range = text.range(of: Tab())
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 2))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 3))
    }
    
}



