/*
import UIKit

class IconLabel: UILabel {
    
    private var textLayer: CATextLayer = CATextLayer()
    
    private var isInitialized: Bool = false
    
    var shadow: Shadow = .normal {
        didSet {
            // 影
            self.textLayer.shadowColor = UIColor.black.cgColor
            self.textLayer.shadowOffset = CGSize(width: 0, height: 0)
            self.textLayer.shadowRadius = 1.0
            switch self.shadow {
            case .none:
                self.shadowOpacity = 0.0
            case .normal:
                self.shadowOpacity = 1.0
            }
        }
    }
    
    var shadowOpacity: Float = 0 {
        didSet {
            self.textLayer.shadowOpacity = self.shadowOpacity
        }
    }
    
    var fontSize: CGFloat = 24.0 {
        didSet {
            self.textLayer.fontSize = self.fontSize
        }
    }
    
    var icon: String = "" {
        didSet {
            self.textLayer.string = self.icon
        }
    }
    
    var color: UIColor = UIColor.white {
        didSet {
            self.textLayer.foregroundColor = self.color.cgColor
        }
    }
    
    
    enum Shadow {
        case none
        case normal
    }
    
    
    func afterInit(icon: String, shadow: Shadow, fontSize: CGFloat, color: UIColor) {
        self.icon = icon
        self.shadow = shadow
        self.fontSize = fontSize
        self.color = color
        self.setTextLayer()
    }
    
    
    func hide() {
        self.alpha = 0.0
    }
    
    
    func show() {
        self.alpha = 1.0
    }
    
    
    private func setTextLayer() {
        self.text = ""
        // 上下中央になるよう調整
        let x: CGFloat = 0
        let y: CGFloat = (self.frame.height - self.fontSize) / 2
        self.textLayer.frame = CGRect(x: x, y: y, width: self.frame.width, height: self.frame.height)
        // 左右中央寄せ
        self.textLayer.alignmentMode = kCAAlignmentCenter
        // Ratina対応
        self.textLayer.contentsScale = UIScreen.main.scale
        
        self.layer.sublayers = nil
        self.layer.addSublayer(self.textLayer)
    }
    
}
*/
