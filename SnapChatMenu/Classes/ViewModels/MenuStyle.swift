
import UIKit

class MenuStyle {
    
    var thenIndex: Int
    
    var delay: CGFloat
    
    var forward: CGFloat
    
    var color: UIColor
    
    var size: CGFloat
    
    var constraint: [CGFloat]
    
    var imageView: UIImageView?
    
    var activeImageView: UIImageView?
    
    var view: UIView?
    
    
    init(thenIndex: Int, delay: CGFloat, forward: CGFloat, color: UIColor, size: CGFloat, constraint: [CGFloat]) {
        
        self.thenIndex = thenIndex
        
        self.delay = delay
        
        self.forward = forward
        
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
    
    
    func setActiveImage(view: UIView, named: String) {
        self.activeImageView = UIImageView(image: UIImage(named: named)?.withRenderingMode(.alwaysTemplate))
        self.activeImageView?.contentMode = .scaleAspectFill
        self.activeImageView?.alpha = 0
        self.activeImageView?.tintColor = UIColor.red
        
        self.updateIconSize(view: view, size: self.size)
        
        if let imageView = self.activeImageView {
            view.addSubview(imageView)
        }
    }
    
    
    func updateIconSize(view: UIView, size: CGFloat) {
        let x: CGFloat = (view.frame.width - size) / 2
        let y: CGFloat = (view.frame.height - size) / 2
        self.imageView?.frame = CGRect(x: x, y: y, width: size, height: size)
        self.activeImageView?.frame = CGRect(x: x, y: y, width: size, height: size)
    }
    
    
    func setBar(view: UIView) {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        self.view?.backgroundColor = self.color
        self.view?.alpha = 0
        
        if let v: UIView = self.view {
            view.addSubview(v)
        }
    }
    
    
    func updateBar(view: UIView, width: CGFloat) {
        if let v: UIView = self.view {
            let x: CGFloat = (view.frame.width - width) / 2
            let y: CGFloat = 0
            self.view?.frame = CGRect(x: x, y: y, width: width, height: v.frame.height)
        }
    }
    
}
