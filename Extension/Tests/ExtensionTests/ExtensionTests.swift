import XCTest
@testable import Extension

final class ExtensionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Extension().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
