import SwiftUI

struct ContentView: View {
    @State private var diaryEntries: [DiaryEntry] = []  // 存储日记项的数组
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // 按日期升序显示日记项
                    ForEach(diaryEntries.sorted { $0.date < $1.date }) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.date, style: .date)  // 显示日记日期
                                .font(.headline)
                            
                            ZStack(alignment: .topTrailing) {
                                // 日记内容框
                                Text(entry.content)  // 显示日记内容
                                    .font(.body)
                                    .padding()  // 内容周围的内边距
                                    .background(Color.gray.opacity(0.1))  // 背景色
                                    .cornerRadius(10)  // 圆角效果
                                    .padding(.vertical, 5)  // 内容之间的垂直间距
                                
                                // 显示心情（右上角）
                                Text(entry.mood)  // 显示心情
                                    .font(.title)
                                    .padding(5)
                                    .background(Color.white.opacity(0.7))  // 背景色稍微透明
                                    .clipShape(Circle())  // 圆形背景
                                    .offset(x: 10, y: -10)  // 右上角偏移
                            }
                        }
                    }
                    .onDelete(perform: deleteEntry)  // 删除单项日记项
                }
                
                // 删除所有日记项按钮
                Button(action: {
                    diaryEntries.removeAll()  // 删除所有日记项
                }) {
                    Text("Delete All Entries")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Diary")
            .navigationBarItems(trailing: NavigationLink(destination: AddEntryView(diaryEntries: $diaryEntries)) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
            })
        }
    }

    // 删除单个日记项
    func deleteEntry(at offsets: IndexSet) {
        diaryEntries.remove(atOffsets: offsets)
    }
}
