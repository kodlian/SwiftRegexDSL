import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CharacterClassTests.allTests),
        testCase(GroupTests.allTests),
        testCase(QuantifierTests.allTests),
        testCase(SpecialCharactersTests.allTests),
        testCase(UnicodeTests.allTests),
        testCase(ControlFlowAndLoopTests.allTests)
    ]
}
#endif
