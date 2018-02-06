
import UIKit

class PVCAnimationStyle {
    
    var thenIndex: Int
    
    var delay: CGFloat
    
    var forward: CGFloat
    
    var color: UIColor
    
    var border: Border
    
    var size: CGFloat
    
    var constraint: [CGFloat]
    
    var imageView: UIView?
    
    var activeImageView: UIView?
    
    var view: UIView?
    
    var label: UILabel?
    
    private var parentLabel: UILabel?
    
    
    enum Border {
        case none
        case shadow
        case circle
        case circleThenActive
        case shadowThenInactiveCircleThenActive
    }
    
    
    init(thenIndex: Int, delay: CGFloat, forward: CGFloat, color: UIColor, border: Border, size: CGFloat, constraint: [CGFloat]?) {
        
        self.thenIndex = thenIndex
        
        self.delay = delay
        
        self.forward = forward
        
        self.color = color
        
        self.border = border
        
        self.size = size
        
        self.constraint = (constraint == nil) ? [CGFloat]() : constraint!
    }
    
    
    // label用
    init(thenIndexForLabel thenIndex: Int, delay: CGFloat, forward: CGFloat, color: UIColor, border: Border, constraint: [CGFloat]?) {
        
        self.thenIndex = thenIndex
        
        self.delay = delay
        
        self.forward = forward
        
        self.color = color
        
        self.border = border
        
        self.size = 0
        
        self.constraint = (constraint == nil) ? [CGFloat]() : constraint!
    }
    
    
    func setImage(view: UIView, named: String) {
        
        let image: UIImage? = UIImage(named: named)
        self.imageView = UIView(frame: view.frame)
        self.imageView?.alpha = 0
        self.imageView?.isUserInteractionEnabled = false
        
        switch self.border {
        case .none:
            fallthrough
        case .circleThenActive:
            self.imageView?.layer.contents = image?.tint(color: self.color).cgImage
        case .shadow:
            fallthrough
        case .shadowThenInactiveCircleThenActive:
            self.imageView?.layer.contents = image?.tint(color: self.color).cgImage
            self.imageView?.layer.shadowColor = UIColor.black.cgColor
            self.imageView?.layer.shadowRadius = 0.6
            self.imageView?.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.imageView?.layer.shadowOpacity = 0.3
        case .circle:
            self.imageView?.layer.contents = image?.tint(color: .white).cgImage
            self.imageView?.layer.shadowColor = self.color.cgColor
            self.imageView?.layer.shadowRadius = 0.1
            self.imageView?.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.imageView?.layer.shadowOpacity = 1
        }
        
        self.updateIconSize(view: view, size: self.size)
        
        if let imageView = self.imageView {
            view.addSubview(imageView)
        }
    }
    
    
    func setActiveImage(view: UIView, named: String) {
        
        let image: UIImage? = UIImage(named: named)
        self.activeImageView = UIView(frame: view.frame)
        self.activeImageView?.alpha = 0
        self.activeImageView?.isUserInteractionEnabled = false
        
        switch self.border {
        case .none:
            self.activeImageView?.layer.contents = image?.tint(color: .red).cgImage
        case .shadow:
            self.activeImageView?.layer.contents = image?.tint(color: .red).cgImage
            self.activeImageView?.layer.shadowColor = UIColor.black.cgColor
            self.activeImageView?.layer.shadowRadius = 0.6
            self.activeImageView?.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.activeImageView?.layer.shadowOpacity = 0.3
        case .circle:
            fallthrough
        case .circleThenActive:
            fallthrough
        case .shadowThenInactiveCircleThenActive:
            self.activeImageView?.layer.contents = image?.tint(color: .white).cgImage
            self.activeImageView?.layer.shadowColor = UIColor.red.cgColor
            self.activeImageView?.layer.shadowRadius = 0.1
            self.activeImageView?.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.activeImageView?.layer.shadowOpacity = 1
        }
        
        self.updateIconSize(view: view, size: self.size)
        
        if let imageView = self.activeImageView {
            view.addSubview(imageView)
        }
    }
    
    
    func updateIconSize(view: UIView, size: CGFloat) {
        let x: CGFloat = (view.frame.width - size) / 2
        let y: CGFloat = (view.frame.height - size) / 2
        self.imageView?.frame = CGRect(x: x, y: y, width: size, height: size)
        self.activeImageView?.frame = CGRect(x: x, y: y, width: size, height: size)
        
        if self.border == .circle {
            let s: CGFloat = size * 2.7
            let offset: CGFloat = (size - s) / 2
            self.imageView?.layer.shadowPath = UIBezierPath(ovalIn: CGRect(x: offset, y: offset, width: s, height: s)).cgPath
        }
        
        if self.border == .circle || self.border == .circleThenActive || self.border == .shadowThenInactiveCircleThenActive {
            var s: CGFloat = 0
            if self.border == .circle {
                s = size * 2.7
            }
            if self.border == .circleThenActive || self.border == .shadowThenInactiveCircleThenActive {
                s = size + size / 2
            }
            let offset: CGFloat = (size - s) / 2
            self.activeImageView?.layer.shadowPath = UIBezierPath(ovalIn: CGRect(x: offset, y: offset, width: s, height: s)).cgPath
        }
    }
    
    
    func setBar(view: UIView) {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        self.view?.backgroundColor = self.color
        self.view?.alpha = 0
        
        if let v: UIView = self.view {
            view.addSubview(v)
        }
    }
    
    
    func updateBar(view: UIView, width: CGFloat) {
        if let v: UIView = self.view {
            let x: CGFloat = (view.frame.width - width) / 2
            let y: CGFloat = 0
            self.view?.frame = CGRect(x: x, y: y, width: width, height: v.frame.height)
        }
    }
    
    
    func setText(label: UILabel) {
        label.textColor = UIColor.clear
        self.parentLabel = label
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: label.frame.width, height: label.frame.height))
        self.label?.font = label.font
        self.label?.text = label.text
        self.label?.textColor = self.color
        self.label?.alpha = 0
        
        if self.border == .shadow {
            self.label?.layer.shadowColor = UIColor.black.cgColor
            self.label?.layer.shadowRadius = 0.6
            self.label?.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.label?.layer.shadowOpacity = 0.3
        }
        
        self.updateLabel()
        if let l: UIView = self.label {
            label.addSubview(l)
        }
    }
    
    
    func updateLabel() {
        if let _: UILabel = self.label, let l: UILabel = self.parentLabel {
            self.label?.frame = CGRect(x: 0, y: 0, width: l.frame.width, height: l.frame.height)
        }
    }
    
}
