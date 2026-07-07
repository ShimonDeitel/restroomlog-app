import SwiftUI

/// Bespoke palette for Restroom Log - Nighttime Bathroom Tracker — night navy.
enum Theme {
    static let accent = Color(red: 0.3, green: 0.6, blue: 0.85)
    static let background = Color(red: 0.04, green: 0.06, blue: 0.1)
    static let cardBackground = Color(red: 0.09, green: 0.11, blue: 0.15000000000000002)
    static let textPrimary = Color.white.opacity(0.92)
    static let textSecondary = Color.white.opacity(0.55)

    static let titleFont = Font.system(.largeTitle, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static var cardCornerRadius: CGFloat { 16 }
}
