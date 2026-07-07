import Foundation

struct RestroomlogEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var date: Date
    var note: String
    var value1: String
    var value2: String

    init(id: UUID = UUID(), date: Date = Date(), note: String = "", value1: String = "", value2: String = "") {
        self.id = id
        self.date = date
        self.note = note
        self.value1 = value1
        self.value2 = value2
    }
}
