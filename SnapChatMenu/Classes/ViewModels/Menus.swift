
import UIKit

class Menus {
    
    private var view: UIView = UIView()
    
    private var firstIndex: Int = 0
    
    private var lists: [Menu] = [Menu]()
    
    
    init(parentView: UIView, index: Int) {
        self.view = parentView
        self.firstIndex = index
    }
    
    
    func append(menu: Menu) {
        for style in menu.styles {
            style.setImage(view: menu.view, named: menu.iconName)
            if self.firstIndex == style.thenIndex {
                style.imageView?.alpha = 1
                menu.constraint.constant = style.constraint
                self.view.layoutIfNeeded()
            }
        }
        self.lists.append(menu)
    }
    
    
    func action(progress: CGFloat, from: Int, to: Int) {
        print(progress, from, to)
        for list in self.lists {
            list.action(progress: progress, from: from, to: to)
        }
        self.view.layoutIfNeeded()
    }
    
}
