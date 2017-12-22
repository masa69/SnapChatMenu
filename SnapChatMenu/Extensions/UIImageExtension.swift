
import UIKit

extension UIImage {
    func tint(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        color.setFill()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(rect)
        draw(in: rect, blendMode: .destinationIn, alpha: 1)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
