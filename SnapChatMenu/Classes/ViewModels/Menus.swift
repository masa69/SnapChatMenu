
import UIKit

class Menus {
    
    private var view: UIView = UIView()
    
    private var index: Int = 0
    
    private var lists: [Menu] = [Menu]()
    
    
    init(parentView: UIView, index: Int) {
        self.view = parentView
        self.index = index
    }
    
    
    func append(menu: Menu) {
        for style in menu.styles {
            if self.index == style.thenIndex {
                var icon: String = ""
                switch menu.index {
                case 0:
                    icon = "▲"
                case 1:
                    icon = "○"
                case 2:
                    icon = "▼"
                default:
                    break
                }
                menu.label.afterInit(icon: icon, shadow: (style.shadow == .none) ? .none : .normal, fontSize: style.size, color: style.color)
                menu.constraint.constant = style.constraint
                self.update()
                break
            }
        }
        self.lists.append(menu)
    }
    
    
    func action(progress: CGFloat, from: Int, to: Int) {
        print(progress, from, to)
        for list in self.lists {
            list.action(progress: progress, from: from, to: to)
        }
        self.update()
    }
    
    
    private func update() {
        self.view.layoutIfNeeded()
    }
    
}
