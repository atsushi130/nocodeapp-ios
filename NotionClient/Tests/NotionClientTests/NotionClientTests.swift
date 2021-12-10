import XCTest
@testable import NotionClient

final class NotionClientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NotionClient().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
