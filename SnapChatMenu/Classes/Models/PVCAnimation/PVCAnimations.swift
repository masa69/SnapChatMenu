
import UIKit

class PVCAnimations {
    
    private var view: UIView = UIView()
    
    private var firstIndex: Int = 0
    
    private var lists: [PVCAnimation] = [PVCAnimation]()
    
    
    init(parentView: UIView, index: Int) {
        self.view = parentView
        self.firstIndex = index
    }
    
    
    func append(animation: PVCAnimation) {
        
        animation.setFirstIndex(index: self.firstIndex)
        
        for style in animation.styles {
            
            switch animation.type {
            case .icon:
                style.setImage(view: animation.view, named: animation.iconName)
                style.setActiveImage(view: animation.view, named: animation.activeIconName)
            case .bar:
                style.setBar(view: animation.view)
            case .text:
                style.setText(label: animation.label)
            }
            
            if self.firstIndex == style.thenIndex {
                
                switch animation.status {
                case .normal:
                    style.imageView?.alpha = 1
                case .active:
                    style.activeImageView?.alpha = 1
                }
                
                style.view?.alpha = 1
                style.label?.alpha = 1
                
                for (i, constraint) in animation.constraint.enumerated() {
                    constraint.constant = style.constraint[i]
                }
                self.view.layoutIfNeeded()
            }
        }
        self.lists.append(animation)
    }
    
    
    func action(progress: CGFloat, from: Int, to: Int) {
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
    
    
    func badge(index: Int, status: PVCAnimation.ObjectBadgeStatus) {
        for list in self.lists {
            if list.index == index {
                list.badgeStatus = status
            }
        }
        self.view.layoutIfNeeded()
    }
    
}
