
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
            switch menu.type {
            case .icon:
                style.setImage(view: menu.view, named: menu.iconName)
                style.setActiveImage(view: menu.view, named: menu.activeIconName)
            case .bar:
                style.setBar(view: menu.view)
            }
            if self.firstIndex == style.thenIndex {
                switch menu.status {
                case .normal:
                    style.imageView?.alpha = 1
                case .active:
                    style.activeImageView?.alpha = 1
                }
                menu.constraint.constant = style.constraint
                self.view.layoutIfNeeded()
            }
        }
        self.lists.append(menu)
    }
    
    
    func action(progress: CGFloat, from: Int, to: Int) {
        // DEBUG
        print(progress, from, to)
        for list in self.lists {
            list.action(progress: progress, from: from, to: to)
        }
        self.view.layoutIfNeeded()
    }
    
    
    func active(index: Int) {
        for list in self.lists {
            if list.index == index {
                list.status = .active
            }
        }
        self.view.layoutIfNeeded()
    }
    
    
    func inactive(index: Int) {
        for list in self.lists {
            if list.index == index {
                list.status = .normal
            }
        }
        self.view.layoutIfNeeded()
    }
    
}
