import XCTest
@testable import Restroomlog

@MainActor
final class RestroomlogStoreTests: XCTestCase {
    var store: RestroomlogStore!

    override func setUp() async throws {
        store = RestroomlogStore()
    }

    func testSeedDataLoadsBelowFreeLimit() throws {
        XCTAssertLessThan(store.entries.count, RestroomlogStore.freeLimit)
    }

    func testCanAddMoreWhenUnderLimit() throws {
        XCTAssertTrue(store.canAddMore)
    }

    func testAddEntryIncreasesCount() throws {
        let before = store.entries.count
        store.add(RestroomlogEntry(value1: "10", value2: "2"))
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testDeleteEntryDecreasesCount() throws {
        store.add(RestroomlogEntry(value1: "10", value2: "2"))
        let before = store.entries.count
        if let id = store.entries.first?.id {
            store.delete(id: id)
        }
        XCTAssertEqual(store.entries.count, before - 1)
    }

    func testFreeLimitBlocksAdditionalEntries() throws {
        for i in 0..<(RestroomlogStore.freeLimit + 5) {
            store.add(RestroomlogEntry(value1: "\(i)", value2: ""))
        }
        XCTAssertEqual(store.entries.count, RestroomlogStore.freeLimit)
        XCTAssertFalse(store.canAddMore)
    }

    func testProBypassesFreeLimit() throws {
        store.isPro = true
        for i in 0..<(RestroomlogStore.freeLimit + 5) {
            store.add(RestroomlogEntry(value1: "\(i)", value2: ""))
        }
        XCTAssertGreaterThan(store.entries.count, RestroomlogStore.freeLimit)
    }

    func testUpdateEntryChangesValue() throws {
        store.add(RestroomlogEntry(value1: "1", value2: ""))
        guard var entry = store.entries.first else { return XCTFail("no entry") }
        entry.value1 = "99"
        store.update(entry)
        XCTAssertEqual(store.entries.first?.value1, "99")
    }

    func testDeleteAtOffsetsWorks() throws {
        let before = store.entries.count
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.entries.count, before - 1)
    }
}
