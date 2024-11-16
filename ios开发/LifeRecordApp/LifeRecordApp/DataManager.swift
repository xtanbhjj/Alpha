import Foundation
import UIKit

class DataManager: ObservableObject {
    @Published var records: [Record] = []

    func addRecord(_ record: Record) {
        records.append(record)
        saveData()
    }

    func saveData() {
        // 实现数据保存逻辑，简单实现可以将数据编码为 JSON 并保存到 UserDefaults
    }

    func loadData() {
        // 实现数据加载逻辑
    }
}
