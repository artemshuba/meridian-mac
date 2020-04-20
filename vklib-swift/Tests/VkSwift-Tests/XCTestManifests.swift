import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(vklib_swiftTests.allTests),
    ]
}
#endif
