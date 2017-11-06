
import UIKit

class TransparentButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.afterInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    private func afterInit() {
        self.alpha = 0
    }
    
}
