import Foundation
import SwiftUI

// 心情类型枚举
enum MoodType: String, CaseIterable, Identifiable, Codable {
    case happy = "😊"
    case sad = "😢"
    case neutral = "😐"
    case angry = "😡"
    case excited = "🤩"
    case relaxed = "😌"
    
    var id: String { self.rawValue }
    
    // 根据心情返回对应的颜色
    var color: Color {
        switch self {
        case .happy:
            return .yellow
        case .sad:
            return .blue
        case .neutral:
            return .gray
        case .angry:
            return .red
        case .excited:
            return .orange
        case .relaxed:
            return .green
        }
    }
}

// 心情记录结构
struct Mood: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var moodType: MoodType
    var note: String
    var likes: Int = 0
    var tags: [String] = [] // 新增标签属性
    
    // 格式化日期，方便展示
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
