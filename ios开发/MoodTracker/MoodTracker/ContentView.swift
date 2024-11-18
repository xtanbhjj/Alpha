import SwiftUI

struct ContentView: View {
    @StateObject var moodData = MoodData()
    @State private var selectedMood: MoodType? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // 心情分类选择器
                Picker("Select Mood", selection: $selectedMood) {
                    Text("All").tag(MoodType?.none) // 显示所有心情记录
                    ForEach(MoodType.allCases) { mood in
                        Text(mood.rawValue).tag(mood as MoodType?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle()) // 分段选择样式
                .padding()
                
                // 列表显示心情记录
                List {
                    // 根据选择的心情类型筛选心情记录
                    ForEach(filteredMoods) { mood in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(mood.moodType.rawValue)
                                    .font(.largeTitle)
                                    .frame(width: 40, height: 40)
                                VStack(alignment: .leading) {
                                    Text(mood.note)
                                        .font(.body)
                                    Text(mood.formattedDate)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("Likes: \(mood.likes)")
                                    .font(.subheadline)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(mood.moodType.color, lineWidth: 2)) // 大框的样式
                            .padding(.vertical, 5)
                            
                            // 点赞按钮
                            Button(action: {
                                moodData.likeMood(mood: mood)
                            }) {
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(.blue)
                                    .padding(5)
                            }
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.top, 5)
                        }
                    }
                }
                
                // 添加 "Add Mood" 按钮
                .navigationBarTitle("Mood Tracker")
                .navigationBarItems(trailing: NavigationLink(destination: MoodDetailView(moodData: moodData)) {
                    Text("Add Mood")
                })
                
                Spacer() // 确保 List 占据剩余空间
            }
            .padding(.top)
        }
    }
    
    // 计算并返回筛选后的心情记录
    private var filteredMoods: [Mood] {
        if let selectedMood = selectedMood {
            return moodData.getMoods().filter { $0.moodType == selectedMood }
        } else {
            return moodData.getMoods() // 如果没有选择心情类型，返回所有记录
        }
    }
}

