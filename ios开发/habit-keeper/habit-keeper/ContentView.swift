import SwiftUI

// 自定义 Activity 结构体
struct Activity: Identifiable, Codable {
    var id = UUID()
    var name: String
    var completionCount: Int
    var motivation: String
    var emoji: String  // emoji 现在是必选的
}

struct ContentView: View {
    @State private var activities = [
        Activity(name: "起床", completionCount: 5, motivation: "今天也是充满活力的一天！", emoji: "🌅"),
        Activity(name: "写作业", completionCount: 3, motivation: "努力的每一刻都值得点赞！", emoji: "📚"),
        Activity(name: "运动", completionCount: 2, motivation: "每一步都让你更强大！", emoji: "🏃‍♂️")
    ]
    
    @State private var newActivityName = ""
    @State private var newMotivation = ""
    @State private var newEmoji = "😊"  // 默认表情
    @State private var showingAddActivitySheet = false
    @State private var showingEmojiPicker = false  // 控制是否显示表情选择器
    
    // 预定义的 emoji 表情列表
    let emojiOptions = ["🌅", "📚", "🏃‍♂️", "🎵", "🎨", "🍎", "🍕", "⚽️", "🎮", "🧘‍♀️"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(activities) { activity in
                        HabitCardView(activity: activity, onCardTapped: {
                            if let index = activities.firstIndex(where: { $0.id == activity.id }) {
                                activities[index].completionCount += 1
                                saveActivities()  // 保存活动数据
                            }
                        })
                        .padding()
                    }
                }
            }
            .navigationBarItems(
                trailing: Button(action: {
                    showingAddActivitySheet.toggle()
                }) {
                    Text("添加")
                }
            )
            .navigationTitle("习惯追踪")
            .sheet(isPresented: $showingAddActivitySheet) {
                VStack {
                    Text("请输入新活动名称")
                        .font(.headline)
                        .padding()
                    
                    TextField("活动名称", text: $newActivityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Text("请输入激励话语")
                        .font(.headline)
                        .padding()
                    
                    TextField("激励话语", text: $newMotivation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Text("选择表情")
                        .font(.headline)
                        .padding()
                    
                    HStack {
                        Text(newEmoji)
                            .font(.largeTitle)
                            .padding()
                        
                        Button("选择表情") {
                            showingEmojiPicker.toggle()
                        }
                        .padding()
                    }
                    
                    // 显示表情选择器
                    if showingEmojiPicker {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(emojiOptions, id: \.self) { emoji in
                                    Text(emoji)
                                        .font(.largeTitle)
                                        .padding(10)
                                        .background(Circle().fill(Color.gray.opacity(0.2)))
                                        .onTapGesture {
                                            newEmoji = emoji
                                            showingEmojiPicker = false
                                        }
                                }
                            }
                        }
                        .padding()
                    }
                    
                    HStack {
                        Button("取消") {
                            showingAddActivitySheet.toggle()
                        }
                        .padding()
                        
                        Spacer()
                        
                        Button("添加") {
                            addActivity()
                            showingAddActivitySheet.toggle()
                        }
                        .padding()
                        .disabled(newActivityName.isEmpty || newMotivation.isEmpty)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            loadActivities()
        }
    }
    
    func addActivity() {
        guard !newActivityName.isEmpty && !newMotivation.isEmpty else { return }
        let newActivity = Activity(
            name: newActivityName,
            completionCount: 0,
            motivation: newMotivation,
            emoji: newEmoji  // 使用选择的 emoji
        )
        activities.append(newActivity)
        newActivityName = ""
        newMotivation = ""
        newEmoji = "😊"  // 重置为默认表情
        saveActivities()
    }
    
    func saveActivities() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(activities) {
            UserDefaults.standard.set(encoded, forKey: "activities")
        }
    }
    
    func loadActivities() {
        if let savedActivities = UserDefaults.standard.data(forKey: "activities") {
            let decoder = JSONDecoder()
            if let loadedActivities = try? decoder.decode([Activity].self, from: savedActivities) {
                activities = loadedActivities
            }
        }
    }
}

struct HabitCardView: View {
    var activity: Activity
    var onCardTapped: () -> Void  // 回调函数用于更新活动的完成次数
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1)) // 暂时使用灰色背景
                .shadow(radius: 10)
                .frame(height: 200)
            
            VStack {
                HStack {
                    Text(activity.emoji)
                        .font(.largeTitle)
                        .padding([.top, .leading])
                    Text(activity.name)
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding([.top, .leading])
                
                Spacer()
                
                HStack {
                    Text("完成次数: \(activity.completionCount) 次")
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        onCardTapped()  // 调用回调函数更新完成次数
                    }) {
                        Text("打卡")
                            .foregroundColor(.blue)
                            .padding(8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding([.bottom, .horizontal])
                
                HStack {
                    Text(activity.motivation)
                        .font(.footnote)
                        .italic()
                        .foregroundColor(.green)
                    Spacer()
                }
                .padding([.bottom, .horizontal])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
