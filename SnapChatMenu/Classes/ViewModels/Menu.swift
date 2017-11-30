
import UIKit

class Menu {
    
    private var key: String
    
    var index: Int
    
    var type: MenuType
    
    var iconName: String
    
    var activeIconName: String
    
    var label: UILabel
    
    var view: UIView
    
    var constraint: [NSLayoutConstraint]
    
    var styles: [MenuStyle] = [MenuStyle]()
    
    private var statusKey: String {
        get {
            return (self.key == "") ? "" : "Menu.status_\(self.key)"
        }
    }
    
    var status: MenuStatus = .normal {
        didSet {
            if self.statusKey != "" {
                UserDefaults.standard.set(self.status.hashValue, forKey: self.statusKey)
            }
            self.action(progress: self.storeProgress, from: self.storeFrom, to: self.storeTo)
        }
    }
    
    private var storeProgress: CGFloat = 0
    // Menus.append(menu: Menu) 時に Menu.setFirstIndex(index: Int) を呼び出す
    private var storeFrom: Int = 0
    private var storeTo: Int = 0
    
    
    enum MenuType {
        case icon
        case bar
        case text
    }
    
    
    enum MenuStatus {
        case normal
        case active
    }
    
    
    init(index: Int, type: MenuType, iconName: String, activeIconName: String, view: UIView, constraint: [NSLayoutConstraint], styles: [MenuStyle]) {
        
        self.index = index
        
        self.type = type
        
        self.iconName = iconName
        
        self.activeIconName = activeIconName
        
        self.label = UILabel()
        
        self.view = view
        
        self.constraint = constraint
        
        self.styles = styles
        
        self.key = ""
    }
    
    
    init(index: Int, key: String, type: MenuType, iconName: String, activeIconName: String, view: UIView, constraint: [NSLayoutConstraint], styles: [MenuStyle]) {
        
        self.index = index
        
        self.type = type
        
        self.iconName = iconName
        
        self.activeIconName = activeIconName
        
        self.label = UILabel()
        
        self.view = view
        
        self.constraint = constraint
        
        self.styles = styles
        
        self.key = key
        
        if self.statusKey != "" {
            if UserDefaults.standard.object(forKey: self.statusKey) != nil {
                let i: Int = UserDefaults.standard.integer(forKey: self.statusKey)
                switch i {
                case 0:
                    self.status = .normal
                case 1:
                    self.status = .active
                default:
                    break
                }
            }
        }
    }
    
    
    init(index: Int, type: MenuType, label: UILabel, constraint: [NSLayoutConstraint], styles: [MenuStyle]) {
        
        self.index = index
        
        self.type = type
        
        self.iconName = ""
        
        self.activeIconName = ""
        
        self.label = label
        
        self.view = UIView()
        
        self.constraint = constraint
        
        self.styles = styles
        
        self.key = ""
    }
    
    
    func setFirstIndex(index: Int) {
        self.storeFrom = index
        self.storeTo = index
    }
    
    
    func action(progress: CGFloat, from: Int, to: Int) {
        guard let fromStyle: MenuStyle = self.getStyle(index: from) else {
            return
        }
        guard let toStyle: MenuStyle = self.getStyle(index: to) else {
            return
        }
        
        self.storeProgress = progress
        self.storeFrom = from
        self.storeTo = to
        
        fromStyle.updateLabel()
        toStyle.updateLabel()
        
        if from == to {
            
            for (i, constraint) in self.constraint.enumerated() {
                constraint.constant = toStyle.constraint[i]
            }
            
            fromStyle.updateIconSize(view: self.view, size: toStyle.size)
            toStyle.updateIconSize(view: self.view, size: toStyle.size)
            
            fromStyle.updateBar(view: self.view, width: toStyle.size)
            toStyle.updateBar(view: self.view, width: toStyle.size)
            
            switch self.status {
            case .normal:
                fromStyle.imageView?.alpha = 0
                toStyle.imageView?.alpha = 1
                fromStyle.activeImageView?.alpha = 0
                toStyle.activeImageView?.alpha = 0
            case .active:
                fromStyle.imageView?.alpha = 0
                toStyle.imageView?.alpha = 0
                fromStyle.activeImageView?.alpha = 0
                toStyle.activeImageView?.alpha = 1
            }
            
            fromStyle.view?.alpha = 0
            toStyle.view?.alpha = 1
            
            fromStyle.label?.alpha = 0
            toStyle.label?.alpha = 1
            return
        }
        
        let ajustProgress: CGFloat = self.ajustProgress(progress: progress, delay: toStyle.delay, forward: toStyle.forward)
        
        for (i, constraint) in self.constraint.enumerated() {
            let diffConstraint: CGFloat = toStyle.constraint[i] - fromStyle.constraint[i]
            constraint.constant = fromStyle.constraint[i] + (diffConstraint * ajustProgress)
        }
        
        let diffIconSize: CGFloat = toStyle.size - fromStyle.size
        let size: CGFloat = fromStyle.size + (diffIconSize * ajustProgress)
        
        fromStyle.updateIconSize(view: self.view, size: size)
        toStyle.updateIconSize(view: self.view, size: size)
        
        fromStyle.updateBar(view: self.view, width: size)
        toStyle.updateBar(view: self.view, width: size)
        
        switch self.status {
        case .normal:
            fromStyle.imageView?.alpha = 1 - ajustProgress
            toStyle.imageView?.alpha = ajustProgress
            fromStyle.activeImageView?.alpha = 0
            toStyle.activeImageView?.alpha = 0
        case .active:
            fromStyle.imageView?.alpha = 0
            toStyle.imageView?.alpha = 0
            fromStyle.activeImageView?.alpha = 1 - ajustProgress
            toStyle.activeImageView?.alpha = ajustProgress
        }
        
        fromStyle.view?.alpha = 1 - ajustProgress
        toStyle.view?.alpha = ajustProgress
        
        fromStyle.label?.alpha = 1 - ajustProgress
        toStyle.label?.alpha = ajustProgress
    }
    
    
    private func getStyle(index: Int) -> MenuStyle? {
        for style in styles {
            if style.thenIndex == index {
                return style
            }
        }
        return nil
    }
    
    
    private func ajustProgress(progress: CGFloat, delay: CGFloat, forward: CGFloat) -> CGFloat {
        if progress <= delay {
            return 0.0
        }
        if progress >= 1 - forward {
            return 1.0
        }
        let rate: CGFloat = 1 / (1 - forward - delay)
        let diff: CGFloat = progress - delay
        return diff * rate
    }
    
}
