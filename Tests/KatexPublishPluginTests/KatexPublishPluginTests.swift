import XCTest
@testable import KatexPublishPlugin

final class KatexPublishPluginTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(KatexPublishPlugin().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
