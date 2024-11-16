import SwiftUI

struct AddRecordView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dataManager: DataManager
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var mood: String = "😊"
    @State private var category: String = "生活"

    var body: some View {
        NavigationView {
            Form {
                TextField("标题", text: $title)
                
                TextEditor(text: $content)
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.vertical)

                Picker("心情", selection: $mood) {
                    Text("😊").tag("😊")
                    Text("😢").tag("😢")
                    Text("😡").tag("😡")
                    Text("😎").tag("😎")
                    Text("🥳").tag("🥳")
                    Text("😱").tag("😱")
                    Text("🤔").tag("🤔")
                }


                Picker("分类", selection: $category) {
                    Text("生活").tag("生活")
                    Text("工作").tag("工作")
                    Text("旅行").tag("旅行")
                }
                
                Button("选择图片") {
                    showImagePicker = true
                }
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                }
            }
            .navigationTitle("添加记录")
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("保存") {
                    let newRecord = Record(
                        title: title,
                        content: content,
                        image: selectedImage,
                        mood: mood,
                        date: Date(),
                        category: category
                    )
                    dataManager.addRecord(newRecord)
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}
