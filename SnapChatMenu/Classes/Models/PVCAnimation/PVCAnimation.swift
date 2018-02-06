
import UIKit

class PVCAnimation {
    
    private var key: String
    
    var index: Int
    
    var type: ObjectType
    
    var iconName: String
    
    var activeIconName: String
    
    var label: UILabel
    
    var view: UIView
    
    var constraint: [NSLayoutConstraint]
    
    var styles: [PVCAnimationStyle] = [PVCAnimationStyle]()
    
    private var statusKey: String {
        get {
            return (self.key == "") ? "" : "PVCAnimation.status_\(self.key)"
        }
    }
    
    var status: ObjectStatus = .normal {
        didSet {
            if self.statusKey != "" {
                UserDefaults.standard.set(self.status.hashValue, forKey: self.statusKey)
            }
            self.action(progress: self.storeProgress, from: self.storeFrom, to: self.storeTo)
        }
    }
    
    private var badgeStatusKey: String {
        get {
            return (self.key == "") ? "" : "PVCAnimation.badge_status_\(self.key)"
        }
    }
    
    var badgeStatus: ObjectBadgeStatus = .off {
        didSet {
            if self.badgeStatusKey != "" {
                UserDefaults.standard.set(self.badgeStatusKey.hashValue, forKey: self.badgeStatusKey)
            }
            self.action(progress: self.storeProgress, from: self.storeFrom, to: self.storeTo)
        }
    }
    
    var badgeView: UIView?
    
    
    private var storeProgress: CGFloat = 0
    // PVCAnimations.append(animation: PVCAnimation) 時に PVCAnimation.setFirstIndex(index: Int) を呼び出す
    private var storeFrom: Int = 0
    private var storeTo: Int = 0
    
    
    enum ObjectType {
        case icon
        case bar
        case text
    }
    
    
    enum ObjectStatus {
        case normal
        case active
    }
    
    
    enum ObjectBadgeStatus {
        case off
        case on
    }
    
    
    init(barIndex index: Int, view: UIView, constraint: [NSLayoutConstraint]?, styles: [PVCAnimationStyle]) {
        
        self.index = index
        
        self.type = .bar
        
        self.iconName = ""
        
        self.activeIconName = ""
        
        self.label = UILabel()
        
        self.view = view
        
        self.constraint = (constraint == nil) ? [NSLayoutConstraint]() : constraint!
        
        self.styles = styles
        
        self.key = ""
        
        self.view.backgroundColor = UIColor.clear
    }
    
    
    init(iconIndex index: Int, key: String, iconName: String, badge: PVCAnimationBadge?, view: UIView, constraint: [NSLayoutConstraint]?, styles: [PVCAnimationStyle]) {
        
        self.index = index
        
        self.type = .icon
        
        self.iconName = iconName
        
        self.activeIconName = iconName
        
        self.label = UILabel()
        
        self.view = view
        
        self.constraint = (constraint == nil) ? [NSLayoutConstraint]() : constraint!
        
        self.styles = styles
        
        self.key = key
        
        self.initBadgeView(badge: badge)
        
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
        
        if self.badgeStatusKey != "" {
            if UserDefaults.standard.object(forKey: self.badgeStatusKey) != nil {
                let i: Int = UserDefaults.standard.integer(forKey: self.badgeStatusKey)
                switch i {
                case 0:
                    self.badgeStatus = .off
                case 1:
                    self.badgeStatus = .on
                default:
                    break
                }
            }
        }
        
        self.view.backgroundColor = UIColor.clear
    }
    
    
    init(textIndex index: Int, label: UILabel, constraint: [NSLayoutConstraint]?, styles: [PVCAnimationStyle]) {
        
        self.index = index
        
        self.type = .text
        
        self.iconName = ""
        
        self.activeIconName = ""
        
        self.label = label
        
        self.view = UIView()
        
        self.constraint = (constraint == nil) ? [NSLayoutConstraint]() : constraint!
        
        self.styles = styles
        
        self.key = ""
    }
    
    
    private func initBadgeView(badge: PVCAnimationBadge?) {
        if self.badgeView == nil {
            let size: CGFloat = 5
            var frame: CGRect = CGRect(x: self.view.frame.width - size, y: 0, width: size, height: size)
            var color: UIColor = UIColor.red
            if let b: PVCAnimationBadge = badge {
                if let f: CGRect = b.frame {
                    frame = f
                }
                if let c: UIColor = b.color {
                    color = c
                }
            }
            self.badgeView = UIView(frame: frame)
            self.badgeView?.backgroundColor = color
            self.badgeView?.layer.masksToBounds = true
            self.badgeView?.layer.cornerRadius = frame.height / 2
            self.badgeView?.alpha = 0
            self.view.addSubview(self.badgeView!)
        }
    }
    
    
    func setFirstIndex(index: Int) {
        self.storeFrom = index
        self.storeTo = index
    }
    
    
    func action(progress: CGFloat, from: Int, to: Int) {
        guard let fromStyle: PVCAnimationStyle = self.getStyle(index: from) else {
            return
        }
        guard let toStyle: PVCAnimationStyle = self.getStyle(index: to) else {
            return
        }
        
        self.storeProgress = progress
        self.storeFrom = from
        self.storeTo = to
        
        fromStyle.updateLabel()
        toStyle.updateLabel()
        
        if let badgeView: UIView = self.badgeView {
            self.view.bringSubview(toFront: badgeView)
            switch self.badgeStatus {
            case .off:
                badgeView.alpha = 0
            case .on:
                badgeView.alpha = 1
            }
        }
        
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
    
    
    private func getStyle(index: Int) -> PVCAnimationStyle? {
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
