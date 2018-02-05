
import UIKit

class PageViewController: PVCAnimationPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure(defaultVc: .second, menus: [
            PVCAnimationVcs(index: 0, key: .first),
            PVCAnimationVcs(index: 1, key: .second),
            PVCAnimationVcs(index: 2, key: .third),
            PVCAnimationVcs(index: 3, key: .fourth),
        ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
