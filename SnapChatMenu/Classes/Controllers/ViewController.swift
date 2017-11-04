
import UIKit

class ViewController: UIViewController {
    
    var pvc: PageViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvc = self.childViewControllers[0] as! PageViewController
        self.pvc.scrolling = { (progress: CGFloat) in
//            print(progress)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

