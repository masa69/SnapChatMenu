
import UIKit

class Menu {
    
    var index: Int
    
    var type: MenuType
    
    var iconName: String
    
    var delay: CGFloat
    
    var forward: CGFloat
    
    var view: UIView
    
    var constraint: NSLayoutConstraint
    
    var styles: [MenuStyle] = [MenuStyle]()
    
    
    enum MenuType {
        case icon
        case bar
    }
    
    
    init(index: Int, type: MenuType, iconName: String, delay: CGFloat, forward: CGFloat, view: UIView, constraint: NSLayoutConstraint, styles: [MenuStyle]) {
        
        self.index = index
        
        self.type = type
        
        self.iconName = iconName
        
        self.delay = delay
        
        self.forward = forward
        
        self.view = view
        
        self.constraint = constraint
        
        self.styles = styles
    }
    
    
    func action(progress: CGFloat, from: Int, to: Int) {
        guard let fromStyle: MenuStyle = self.getStyle(index: from) else {
            return
        }
        guard let toStyle: MenuStyle = self.getStyle(index: to) else {
            return
        }
        
        if from == to {
            self.constraint.constant = toStyle.constraint
            fromStyle.updateIconSize(view: self.view, size: toStyle.size)
            toStyle.updateIconSize(view: self.view, size: toStyle.size)
            fromStyle.imageView?.alpha = 0
            toStyle.imageView?.alpha = 1
            fromStyle.view?.alpha = 0
            toStyle.view?.alpha = 1
            return
        }
        
        let diffConstraint: CGFloat = toStyle.constraint - fromStyle.constraint
        self.constraint.constant = fromStyle.constraint + (diffConstraint * progress)
        
        let diffIconSize: CGFloat = toStyle.size - fromStyle.size
        let size: CGFloat = fromStyle.size + (diffIconSize * progress)
        
        fromStyle.updateIconSize(view: self.view, size: size)
        toStyle.updateIconSize(view: self.view, size: size)
        
        fromStyle.updateBar(view: self.view, width: size)
        toStyle.updateBar(view: self.view, width: size)
        
        fromStyle.imageView?.alpha = 1 - progress
        toStyle.imageView?.alpha = progress
        
        fromStyle.view?.alpha = 1 - progress
        toStyle.view?.alpha = progress
    }
    
    
    private func getStyle(index: Int) -> MenuStyle? {
        for style in styles {
            if style.thenIndex == index {
                return style
            }
        }
        return nil
    }
    
}
