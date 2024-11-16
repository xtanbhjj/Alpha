import SwiftUI

struct RecordDetailView: View {
    var record: Record

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(record.title)
                    .font(.largeTitle)
                    .bold()
                Text(record.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                if let image = record.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }

                Text(record.mood)
                    .font(.title)
                
                Text(record.content)
                    .font(.body)
                    .padding(.top)

                Text("分类: \(record.category)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("日记详情")
    }
}
