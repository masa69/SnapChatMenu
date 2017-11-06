
import UIKit

class MenuStyle {
    
    var thenIndex: Int
    
    var color: UIColor
    
    var shadow: ShadowType
    
    var size: CGFloat
    
    var constraint: CGFloat
    
    
    enum ShadowType {
        case none
        case normal
    }
    
    
    init(thenIndex: Int, color: UIColor, shadow: ShadowType, size: CGFloat, constraint: CGFloat) {
        
        self.thenIndex = thenIndex
        
        self.color = color
        
        self.shadow = shadow
        
        self.size = size
        
        self.constraint = constraint
    }
    
}
