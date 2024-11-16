import SwiftUI

struct MoodDetailView: View {
    @ObservedObject var moodData: MoodData
    @State private var selectedMood: MoodType = .neutral
    @State private var note: String = ""
    @State private var tags: String = "" // 标签输入
    
    @Environment(\.dismiss) var dismiss // 用于返回上一界面
    
    var body: some View {
        Form {
            Section(header: Text("Mood")) {
                Picker("Select Mood", selection: $selectedMood) {
                    ForEach(MoodType.allCases) { mood in
                        Text(mood.rawValue).tag(mood)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Notes")) {
                TextField("Enter any notes", text: $note)
            }
            
            Section(header: Text("Tags (Optional)")) {
                TextField("Enter tags (comma separated)", text: $tags)
                    .keyboardType(.asciiCapable) // 只允许输入英文和符号
            }
            
            Button("Save") {
                // 如果标签不为空，将标签分割成数组
                let tagArray = tags.isEmpty ? [] : tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                let newMood = Mood(date: Date(), moodType: selectedMood, note: note, tags: tagArray)
                moodData.addMood(mood: newMood)
                
                // 保存之后返回到主界面
                dismiss()
            }
            .padding()
        }
        .navigationBarTitle("Add Mood", displayMode: .inline)
    }
}
