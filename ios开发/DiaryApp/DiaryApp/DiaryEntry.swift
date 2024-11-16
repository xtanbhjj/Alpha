import Foundation

struct DiaryEntry: Identifiable {
    let id = UUID()  // 每个日记项都有一个唯一的ID
    var date: Date
    var content: String
    var mood: String  // 存储心情
}
