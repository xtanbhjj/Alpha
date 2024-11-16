import SwiftUI

struct ContentView: View {
    @StateObject var dataManager = DataManager()
    @State private var showAddRecordView = false
    @State private var selectedCategory: String = "全部"
    private var dailyQuote: String { getRandomQuote() }  // 获取每日一句

    var filteredRecords: [Record] {
        if selectedCategory == "全部" {
            return dataManager.records
        } else {
            return dataManager.records.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // 显示每日一句
                Text(dailyQuote)
                    .font(.title2)
                    .italic()
                    .padding()

                // 分类选择器
                Picker("分类", selection: $selectedCategory) {
                    Text("全部").tag("全部")
                    Text("生活").tag("生活")
                    Text("工作").tag("工作")
                    Text("旅行").tag("旅行")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // 日记列表
                List(filteredRecords) { record in
                    NavigationLink(destination: RecordDetailView(record: record)) {
                        VStack(alignment: .leading) {
                            Text(record.title)
                                .font(.headline)
                            Text(record.date, style: .date)
                                .font(.subheadline)
                            if let image = record.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                            }
                        }
                    }
                }
                .navigationTitle("Life Records")
                .toolbar {
                    // 添加按钮
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showAddRecordView = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    // 统计按钮
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: StatsView(dataManager: dataManager)) {
                            Text("统计")
                        }
                    }
                }
                .sheet(isPresented: $showAddRecordView) {
                    AddRecordView(dataManager: dataManager)
                }
            }
        }
    }
}
