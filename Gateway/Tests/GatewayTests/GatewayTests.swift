import XCTest
@testable import Gateway

final class GatewayTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Gateway().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
