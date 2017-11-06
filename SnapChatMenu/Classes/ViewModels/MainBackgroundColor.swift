
import UIKit

class MainBackgroundColor {
    
    var index: Int
    
    private var color: UInt
    
    var view: UIView
    
    var alpha: Float = 0.0 {
        didSet {
            self.view.backgroundColor = UIColor.rgb(rgbValue: self.color, alpha: self.alpha)
        }
    }
    
    
    init(index: Int, color: UInt, parentView: UIView) {
        
        self.index = index
        
        self.color = color
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: parentView.frame.width, height: parentView.frame.height))
        
        self.view.backgroundColor = UIColor.rgb(rgbValue: self.color, alpha: self.alpha)
        
        parentView.addSubview(self.view)
        parentView.layoutIfNeeded()
    }
    
}
