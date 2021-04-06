
import Foundation
struct Currency : Decodable {
    //Properties
    let rates: [String:Double]
    let date : String
}
