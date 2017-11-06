
import UIKit

class MenuStyle {
    
    var thenIndex: Int
    
    var color: UIColor
    
    var size: CGFloat
    
    var constraint: CGFloat
    
    var imageView: UIImageView?
    
    
    init(thenIndex: Int, color: UIColor, size: CGFloat, constraint: CGFloat) {
        
        self.thenIndex = thenIndex
        
        self.color = color
        
        self.size = size
        
        self.constraint = constraint
    }
    
    
    func setImage(view: UIView, named: String) {
        self.imageView = UIImageView(image: UIImage(named: named)?.withRenderingMode(.alwaysTemplate))
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.alpha = 0
        self.imageView?.tintColor = self.color
        
        self.updateIconSize(view: view, size: self.size)
        
        if let imageView = self.imageView {
            view.addSubview(imageView)
        }
    }
    
    
    func updateIconSize(view: UIView, size: CGFloat) {
        let x: CGFloat = (view.frame.width - size) / 2
        let y: CGFloat = (view.frame.height - size) / 2
        self.imageView?.frame = CGRect(x: x, y: y, width: size, height: size)
    }
    
}
