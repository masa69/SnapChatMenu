
import UIKit

class Menu {
    
    var index: Int
    
    var iconName: String
    
    var view: UIView
    
    var constraint: NSLayoutConstraint
    
    var styles: [MenuStyle] = [MenuStyle]()
    
    
    init(index: Int, iconName: String, view: UIView, constraint: NSLayoutConstraint, styles: [MenuStyle]) {
        
        self.index = index
        
        self.iconName = iconName
        
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
            return
        }
        
        let diffConstraint: CGFloat = toStyle.constraint - fromStyle.constraint
        self.constraint.constant = fromStyle.constraint + (diffConstraint * progress)
        
        let diffIconSize: CGFloat = toStyle.size - fromStyle.size
        let iconSize: CGFloat = fromStyle.size + (diffIconSize * progress)
        fromStyle.updateIconSize(view: self.view, size: iconSize)
        toStyle.updateIconSize(view: self.view, size: iconSize)
        
        fromStyle.imageView?.alpha = 1 - progress
        toStyle.imageView?.alpha = progress
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
