
import UIKit

class PageViewController: PVCAnimationPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure(defaultVc: .second, menus: [
            PVCAnimationVCs(index: 0, key: .first),
            PVCAnimationVCs(index: 1, key: .second),
            PVCAnimationVCs(index: 2, key: .third),
            PVCAnimationVCs(index: 3, key: .fourth),
        ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
