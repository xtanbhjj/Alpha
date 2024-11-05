import Foundation


// ToDoItem 数据结构
struct ToDoItem: Identifiable {
    let id = UUID()
    var title: String
    var tag: String
    var priority: Priority
    var dueDate: Date
    var completionDate: Date // 新增属性选择完成时间
    var isCompleted: Bool = false
}

// Priority 枚举
enum Priority: String {
    case high = "重要"
    case normal = "普通"
    case low = "低"
}
