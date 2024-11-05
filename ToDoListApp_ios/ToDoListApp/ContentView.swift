import SwiftUI

struct ContentView: View {
    @State private var toDoItems: [ToDoItem] = []
    @State private var newToDoTitle: String = ""
    @State private var selectedTag: String = "无标签"
    @State private var selectedPriority: Priority = .normal
    @State private var newDueDate = Date()
    @State private var selectedCategory: String = "所有"
    @State private var newCompletionDate = Date() // 新增属性选择完成时间
    
    let tags = ["无标签", "工作", "学习", "生活"]
    let categories = ["所有", "工作", "学习", "生活"] // 分类
    let priorities: [Priority] = [.high, .normal, .low]

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("添加新待办事项", text: $newToDoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addNewToDo) {
                        Text("添加")
                    }
                }
                .padding()

                Picker("选择标签", selection: $selectedTag) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                Picker("选择优先级", selection: $selectedPriority) {
                    ForEach(priorities, id: \.self) { priority in
                        Text(priority.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                DatePicker("预定完成时间", selection: $newDueDate, displayedComponents: .date)
                    .padding(.horizontal)

                // 添加具体完成时间选择器
                DatePicker("选择具体完成时间", selection: $newCompletionDate, displayedComponents: .hourAndMinute)
                    .padding(.horizontal)

                // 分类选择器
                Picker("选择分类", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                List {
                    // 过滤并展示待办事项
                    ForEach(sortedToDoItems.filter { selectedCategory == "所有" || $0.tag == selectedCategory }) { item in
                        HStack {
                            // 勾选完成按钮
                            Button(action: { toggleCompletion(for: item) }) {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray)
                            }

                            // 待办事项文本
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundColor(item.isCompleted ? .gray : .primary)
                                    .strikethrough(item.isCompleted) // 添加横线
                                Text(item.tag)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("预定完成于 \(item.dueDate, formatter: dateFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("完成时间: \(item.completionDate, formatter: dateFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.leading, 8) // 添加左边距，避免与按钮重叠

                            Spacer()

                            // 显示优先级
                            Text(priorityLabel(for: item.priority))
                                .font(.caption)
                                .padding(5)
                                .background(priorityColor(for: item.priority))
                                .cornerRadius(5)

                            // 删除按钮
                            Button(action: {
                                deleteItem(item) // 直接删除待办事项
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(PlainButtonStyle()) // 设置为平坦按钮，避免视觉干扰
                            .padding(.leading, 10) // 给删除按钮添加左边距，避免重叠
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("待办事项")
        }
    }

    // 新增待办事项
    private func addNewToDo() {
        let newItem = ToDoItem(title: newToDoTitle, tag: selectedTag, priority: selectedPriority, dueDate: newDueDate, completionDate: newCompletionDate)
        toDoItems.append(newItem)
        newToDoTitle = ""
    }

    // 切换完成状态
    private func toggleCompletion(for item: ToDoItem) {
        if let index = toDoItems.firstIndex(where: { $0.id == item.id }) {
            toDoItems[index].isCompleted.toggle()

            // 如果标记为完成，移到列表末尾
            if toDoItems[index].isCompleted {
                let completedItem = toDoItems.remove(at: index)
                toDoItems.append(completedItem) // 移到末尾
            }
        }
    }

    // 删除待办事项
    private func deleteItem(_ item: ToDoItem) {
        toDoItems.removeAll { $0.id == item.id }
    }

    // 按完成状态、优先级和预定完成时间排序
    private var sortedToDoItems: [ToDoItem] {
        toDoItems.sorted { first, second in
            if first.isCompleted != second.isCompleted {
                return !first.isCompleted // 未完成的事项优先显示
            }
            if first.priority != second.priority {
                return first.priority.rawValue > second.priority.rawValue // 按优先级排序
            }
            return first.dueDate < second.dueDate // 按预定完成时间排序
        }
    }

    // 返回优先级标签
    private func priorityLabel(for priority: Priority) -> String {
        switch priority {
        case .high:
            return "重要"
        case .normal:
            return "普通"
        case .low:
            return "低"
        }
    }

    // 返回优先级对应的颜色
    private func priorityColor(for priority: Priority) -> Color {
        switch priority {
        case .high:
            return Color.red.opacity(0.2)
        case .normal:
            return Color.yellow.opacity(0.2)
        case .low:
            return Color.green.opacity(0.2)
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

