//
//  File.swift
//  
//
//  Created by Jeremy Marchand on 11/09/2020.
//

import XCTest
@testable import SwiftRegexDSL

final class ControlFlowAndLoopTests: XCTestCase {

    func testOptionalWithIfStatement() {
        struct OptionalContent: Regex {
            let content: Regex?

            var body: Regex {
                "a"
                if let content = content {
                    content
                }
                "c"
            }
        }

        XCTAssertEqual(OptionalContent(content: nil).rawRegex, "ac")
        XCTAssertEqual(OptionalContent(content: Text("b")).rawRegex, "abc")
    }

    func testOptionalExpression() {
        struct OptionalContent: Regex {
            let content: Regex?

            var body: Regex {
                "a"
                content
                "c"
            }
        }

        XCTAssertEqual(OptionalContent(content: nil).rawRegex, "ac")
        XCTAssertEqual(OptionalContent(content: Text("b")).rawRegex, "abc")
    }
    
    func testForLoop() {
        struct LoopRegex: Regex {
            var body: Regex {
                for character in ["a", "b", "c", "d"] {
                    character
                }
            }
        }

        XCTAssertEqual(LoopRegex().rawRegex, "abcd")
    }
    
    func testIfElse() {
        struct IfElseRegex: Regex {
            let displayNumber: Bool

            var body: Regex {
                "a"
                if displayNumber {
                    2
                } else {
                    "b"
                }
                "c"
            }
        }

        XCTAssertEqual(IfElseRegex(displayNumber: true).rawRegex, "a2c")
        XCTAssertEqual(IfElseRegex(displayNumber: false).rawRegex, "abc")
    }
}



