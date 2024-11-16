import Foundation

class MoodData: ObservableObject {
    @Published var moods: [Mood] {
        didSet {
            saveMoods()
        }
    }
    
    // 使用懒加载来避免在初始化时调用 self
    init() {
        self.moods = [] // 初始化时为空数组
        loadMoods() // 在初始化后调用方法
    }
    
    // 添加新的心情记录
    func addMood(mood: Mood) {
        moods.append(mood)
    }
    
    // 获取所有心情记录
    func getMoods() -> [Mood] {
        return moods
    }
    
    // 点赞功能
    func likeMood(mood: Mood) {
        if let index = moods.firstIndex(where: { $0.id == mood.id }) {
            moods[index].likes += 1
        }
    }
    
    // 存储心情记录到 UserDefaults
    private func saveMoods() {
        if let encodedData = try? JSONEncoder().encode(moods) {
            UserDefaults.standard.set(encodedData, forKey: "moods")
        }
    }
    
    // 从 UserDefaults 加载心情记录
    private func loadMoods() {
        if let data = UserDefaults.standard.data(forKey: "moods"),
           let decodedMoods = try? JSONDecoder().decode([Mood].self, from: data) {
            self.moods = decodedMoods
        }
    }
}
