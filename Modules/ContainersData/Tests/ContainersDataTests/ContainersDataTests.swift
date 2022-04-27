import XCTest
@testable import ContainersData

final class Tests: XCTestCase {
        func testLookup() throws {
                let search: [String] = Lookup.search(for: "我")
                let lookup: String = search.first!
                XCTAssertEqual(lookup, "ngo5")
        }
}
