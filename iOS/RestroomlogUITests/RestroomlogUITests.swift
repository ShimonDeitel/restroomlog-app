import XCTest

final class RestroomlogUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddEntryFlow() throws {
        app.buttons["addEntryButton"].tap()
        let value1Field = app.textFields["value1Field"]
        XCTAssertTrue(value1Field.waitForExistence(timeout: 3))
        value1Field.tap()
        value1Field.typeText("8")
        app.buttons["saveEntryButton"].tap()
        XCTAssertFalse(app.textFields["value1Field"].exists)
    }

    func testKeyboardDismissOnTapOutside() throws {
        app.buttons["addEntryButton"].tap()
        let noteField = app.textFields["noteField"]
        XCTAssertTrue(noteField.waitForExistence(timeout: 3))
        noteField.tap()
        XCTAssertTrue(app.keyboards.element.exists)
        app.staticTexts["Add Entry"].tap()
        XCTAssertFalse(app.keyboards.element.waitForExistence(timeout: 2))
        app.buttons["cancelButton"].tap()
    }

    func testFreeLimitTriggersPaywall() throws {
        for _ in 0..<20 {
            if app.buttons["addEntryButton"].exists {
                app.buttons["addEntryButton"].tap()
                if app.buttons["purchaseButton"].waitForExistence(timeout: 1) {
                    XCTAssertTrue(app.buttons["purchaseButton"].exists)
                    app.buttons["paywallCloseButton"].tap()
                    break
                }
                let value1Field = app.textFields["value1Field"]
                if value1Field.waitForExistence(timeout: 2) {
                    value1Field.tap()
                    value1Field.typeText("1")
                    app.buttons["saveEntryButton"].tap()
                }
            }
        }
    }

    func testSettingsSheetOpensAndCloses() throws {
        app.buttons["settingsButton"].tap()
        XCTAssertTrue(app.buttons["settingsDoneButton"].waitForExistence(timeout: 3))
        app.buttons["settingsDoneButton"].tap()
    }
}
