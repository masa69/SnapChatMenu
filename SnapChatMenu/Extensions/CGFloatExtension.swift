
import UIKit

extension CGFloat {
    func percent(depth: Int) -> CGFloat {
        var d: CGFloat = 100
        if depth > 0 {
            for _ in 1...depth {
                d = d * 10
            }
        }
        let i: Int = Int(self * d)
        let f: CGFloat = CGFloat(i)
        return f / d
    }
}
