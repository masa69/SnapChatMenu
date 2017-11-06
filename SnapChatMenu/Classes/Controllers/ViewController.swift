
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftView: TransparentView!
    @IBOutlet weak var leftLabel: IconLabel!
    @IBOutlet weak var leftButton: TransparentButton!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var centerView: TransparentView!
    @IBOutlet weak var centerLabel: IconLabel!
    @IBOutlet weak var centerButton: TransparentButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightView: TransparentView!
    @IBOutlet weak var rightLabel: IconLabel!
    @IBOutlet weak var rightButton: TransparentButton!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    
    var pvc: PageViewController!
    
    var menus: Menus!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        
        self.pvc = self.childViewControllers[0] as! PageViewController
        self.pvc.scrolling = { (progress: CGFloat, from: Int, to: Int) in
            self.menus.action(progress: progress, from: from, to: to)
        }
        if let currentIndex: Int = self.pvc.currentIndex() {
            self.initMenu(currentIndex: currentIndex)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func initMenu(currentIndex: Int) {
        self.menus = Menus(parentView: self.view, index: currentIndex)
        // index: 0 - 2
        self.menus.append(menu: Menu(
            index: 0, view: leftView, label: leftLabel, constraint: leftConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, shadow: .none, size: 18.0, constraint: leftConstraint.constant),
                MenuStyle(thenIndex: 1, color: UIColor.white, shadow: .normal, size: 24.0, constraint: self.view.frame.width / 2 - 80),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, shadow: .none, size: 18.0, constraint: leftConstraint.constant),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, view: centerView, label: centerLabel, constraint: centerConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, shadow: .none, size: 18.0, constraint: centerConstraint.constant),
                MenuStyle(thenIndex: 1, color: UIColor.white, shadow: .normal, size: 50.0, constraint: centerConstraint.constant + 35),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, shadow: .none, size: 18.0, constraint: centerConstraint.constant),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 2, view: rightView, label: rightLabel, constraint: rightConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, shadow: .none, size: 18.0, constraint: rightConstraint.constant),
                MenuStyle(thenIndex: 1, color: UIColor.white, shadow: .normal, size: 24.0, constraint: self.view.frame.width / 2 - 80),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, shadow: .none, size: 18.0, constraint: rightConstraint.constant),
            ]
        ))
    }
    
}

