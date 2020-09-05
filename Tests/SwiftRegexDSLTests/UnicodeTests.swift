//
//  File.swift
//  
//
//  Created by Jeremy Marchand on 11/09/2020.
//

import XCTest
@testable import SwiftRegexDSL

final class UnicodeTests: XCTestCase {
    func testSmiley() {
        let text = "foo😀foo"
        let range = text.range(of: UnsafeUnicode(0x1F600))
        
        XCTAssertEqual(range?.lowerBound, text.index(text.startIndex, offsetBy: 3))
        XCTAssertEqual(range?.upperBound, text.index(text.startIndex, offsetBy: 4))
    }
}
