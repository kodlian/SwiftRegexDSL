//
//  File.swift
//  
//
//  Created by Jeremy Marchand on 17/09/2020.
//

import XCTest
@testable import SwiftRegexDSL

final class GroupTests: XCTestCase {
    // MARK: - Capturing
    func testNonCapturing() {
        let text = "fooa2foo"
        
        let regex = Group {
            "a"
            Digit()
        }
        
        guard let range = text.range(of: regex) else {
            XCTFail()
            return
        }
        let capturedRanges = text.capturedGroupsRanges(of: regex)

        XCTAssertEqual(text[range], "a2")
        XCTAssertEqual(capturedRanges.count, 0)
    }
    
    // MARK: Non-Capturing
    func testCapturing() {
        let text = "fooa2foo"
        
        let regex = CapturingGroup {
            "a"
            Digit()
        }
        
        guard let range = text.range(of: regex) else {
            XCTFail()
            return
        }
        guard let capturedRange = text.capturedGroupsRanges(of: regex).first?.first else {
            XCTFail()
            return
        }

        XCTAssertEqual(text[range], "a2")
        XCTAssertEqual(range, capturedRange)
    }
    
    // MARK: Alternative
    func testAlternative() {
        let regex = Alternative {
            "a"
            "b1"
            "cc3"
        }
        
        XCTAssertNotNil("zzazz".range(of: regex))
    }
    
    // MARK: Assertion
    func testLookAheadAssertion() {
        let regex = Group {
            LookAheadAssertion {
                "foo"
            }
            "foo"
        }
        
        XCTAssertNotNil("foo".range(of: regex))
        XCTAssertNil("oof".range(of: regex))
    }
    
    func testNegativeLookAheadAssertion() {
        let regex = Group {
            NegativeLookAheadAssertion {
                "oof"
            }
            "foo"
        }
        
        XCTAssertNil("oof".range(of: regex))
        XCTAssertNotNil("foo".range(of: regex))
    }
    
    func testLookBehindAssertion() {
        let regex = Group {
            "foo"
            LookBehindAssertion {
                "foo"
            }
        }
        
        XCTAssertNotNil("foo".range(of: regex))
        XCTAssertNil("oof".range(of: regex))
    }
    
    func testNegativeLookBehindAssertion() {
        let regex = Group {
            "foo"
            NegativeLookBehindAssertion {
                "oof"
            }
        }
        
        XCTAssertNil("oof".range(of: regex))
        XCTAssertNotNil("foo".range(of: regex))
    }
    
    // MARK: Pattern Options
    func testCaseInsensitive() {

        let regex = Group {
            "foo"
        }.options(.caseInsensitive)
        
        XCTAssertNotNil("FOO".range(of: regex))
    }
}
