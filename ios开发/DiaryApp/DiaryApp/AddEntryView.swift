import SwiftUI

struct AddEntryView: View {
    @Binding var diaryEntries: [DiaryEntry]  // 绑定到父视图中的日记项数组
    @State private var content: String = ""   // 日记内容
    @State private var date: Date = Date()    // 日记记录时间
    @State private var mood: String = "😊"    // 默认心情是😊
    @Environment(\.presentationMode) var presentationMode  // 获取当前视图的presentationMode
    
    let moods = ["😊", "😢", "😎", "😡", "😍", "😌"]  // 可选心情
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Date")) {
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                }
                
                Section(header: Text("Content")) {
                    TextEditor(text: $content)  // 使用 TextEditor 替代 TextField
                        .padding()  // 增加内边距
                        .frame(minHeight: 200)  // 设置最小高度
                        .background(Color.gray.opacity(0.1))  // 背景色
                        .cornerRadius(10)  // 圆角效果
                        .padding(.vertical)
                        .lineLimit(nil)  // 允许多行
                }
                
                Section(header: Text("Mood")) {
                    Picker("Select Mood", selection: $mood) {
                        ForEach(moods, id: \.self) { mood in
                            Text(mood).tag(mood)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())  // 使用分段选择样式
                }
                
                Button("Save") {
                    let newEntry = DiaryEntry(date: date, content: content, mood: mood)
                    diaryEntries.append(newEntry)  // 添加新日记项
                    
                    // 自动返回到主页面
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(content.isEmpty)  // 如果内容为空，禁用保存按钮
            }
            .navigationTitle("Add Diary Entry")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()  // 取消时返回
            })
        }
    }
}
