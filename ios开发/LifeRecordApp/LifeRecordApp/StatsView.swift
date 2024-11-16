import SwiftUI

struct StatsView: View {
    @ObservedObject var dataManager: DataManager

    var moodCounts: [String: Int] {
        var counts = [String: Int]()
        for record in dataManager.records {
            counts[record.mood, default: 0] += 1
        }
        return counts
    }

    var categoryCounts: [String: Int] {
        var counts = [String: Int]()
        for record in dataManager.records {
            counts[record.category, default: 0] += 1
        }
        return counts
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("心情统计")) {
                    ForEach(moodCounts.sorted(by: { $0.key < $1.key }), id: \.key) { mood, count in
                        HStack {
                            Text(mood)
                            Spacer()
                            Text("\(count) 条记录")
                        }
                    }
                }

                Section(header: Text("分类统计")) {
                    ForEach(categoryCounts.sorted(by: { $0.key < $1.key }), id: \.key) { category, count in
                        HStack {
                            Text(category)
                            Spacer()
                            Text("\(count) 条记录")
                        }
                    }
                }
            }
            .navigationTitle("统计数据")
        }
    }
}
