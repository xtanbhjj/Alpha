import Foundation
import UIKit

struct Record: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var image: UIImage?
    var mood: String
    var date: Date
    var category: String
}
