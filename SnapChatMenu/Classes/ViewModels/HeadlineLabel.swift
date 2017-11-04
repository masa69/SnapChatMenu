
import UIKit

class HeadlineLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.afterInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    private func afterInit() {
        self.textColor = UIColor.white
    }
    
}
