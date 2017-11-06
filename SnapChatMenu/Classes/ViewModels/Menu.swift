
import UIKit

class Menu {
    
    var index: Int
    
    var view: UIView
    
    var label: IconLabel
    
    var constraint: NSLayoutConstraint
    
    var styles: [MenuStyle] = [MenuStyle]()
    
    
    init(index: Int, view: UIView, label: IconLabel, constraint: NSLayoutConstraint, styles: [MenuStyle]) {
        
        self.index = index
        
        self.view = view
        
        self.label = label
        
        self.constraint = constraint
        
        self.styles = styles
    }
    
    
    func action(progress: CGFloat, from: Int, to: Int) {
        if from == to {
            return
        }
        guard let fromStyle: MenuStyle = self.getStyle(index: from) else {
            return
        }
        guard let toStyle: MenuStyle = self.getStyle(index: to) else {
            return
        }
        let diff: CGFloat = toStyle.constraint - fromStyle.constraint
        self.constraint.constant = fromStyle.constraint + (diff * progress)
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
