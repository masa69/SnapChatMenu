
import UIKit

class PVCBackgroundAnimations {
    
    let red: UInt = 0xff6666
    
    let green: UInt = 0x44cc88
    
    let view: UIView
    
    var lists: [PVCBackgroundAnimation] = [PVCBackgroundAnimation]()
    
    
    init(parentView: UIView) {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: parentView.frame.width, height: parentView.frame.height))
        if parentView.subviews.count == 0 {
            parentView.addSubview(self.view)
        }
    }
    
    
    func append(index: Int, color: UInt) {
        self.lists.append(PVCBackgroundAnimation(
            index: index,
            color: color,
            parentView: self.view
        ))
    }
    
    
    // to: 0 - 2
    func action(progress: CGFloat, from: Int, to: Int) {
        
        let fromView: PVCBackgroundAnimation? = self.getView(index: from)
        let toView: PVCBackgroundAnimation? = self.getView(index: to)
        let alpha: Float = Float(progress)
        
        if from == to {
            fromView?.alpha = 0
            toView?.alpha = 1
            return
        }
        
        fromView?.alpha = 1 - alpha
        toView?.alpha = alpha
        
        self.view.layoutIfNeeded()
    }
    
    
    private func getView(index: Int) -> PVCBackgroundAnimation? {
        for list in self.lists {
            if list.index == index {
                return list
            }
        }
        return nil
    }
    
}
