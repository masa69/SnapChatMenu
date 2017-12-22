
import UIKit

class TransparentButton: DefaultButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    private func afterInit() {
        self.setTitle("", for: .normal)
        self.backgroundColor = UIColor.clear
    }

}
