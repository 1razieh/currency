
import Foundation
struct Currency : Decodable {
    let rates: [String:Double]
    let date : String
}
