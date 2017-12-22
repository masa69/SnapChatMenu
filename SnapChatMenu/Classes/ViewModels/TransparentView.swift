
import UIKit

class TransparentView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    private func afterInit() {
        self.backgroundColor = UIColor.clear
    }
    
}
