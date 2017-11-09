
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bgView: TransparentView!
    
    // global menu
    @IBOutlet weak var leftView: TransparentView!
    @IBOutlet weak var leftButton: TransparentButton!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var centerView: TransparentView!
    @IBOutlet weak var centerButton: TransparentButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightView: TransparentView!
    @IBOutlet weak var rightButton: TransparentButton!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightBottomConstraint: NSLayoutConstraint!
    
    // global menu bar
    @IBOutlet weak var leftBarView: TransparentView!
    @IBOutlet weak var leftBarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightBarView: TransparentView!
    @IBOutlet weak var rightBarConstraint: NSLayoutConstraint!
    
    // debug button
    @IBOutlet weak var debugLeftButton: UIButton!
    @IBOutlet weak var debugRightButton: UIButton!
    
    
    var pvc: PageViewController!
    
    var menus: Menus!
    
    var bgViews: MainBackgroundColors?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue
        
        self.pvc = self.childViewControllers[0] as! PageViewController
        self.pvc.scrolling = { (progress: CGFloat, from: Int, to: Int) in
            self.bgViews?.action(progress: progress, from: from, to: to)
            self.menus.action(progress: progress, from: from, to: to)
        }
        if let currentIndex: Int = self.pvc.currentIndex() {
            self.initMenu(currentIndex: currentIndex)
        }
        
        self.initDebugButton()
        self.initVcCallback()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentIndex: Int = self.pvc.currentIndex() {
            self.initMainBg(currentIndex: currentIndex)
        }
    }
    
    
    private func initMainBg(currentIndex: Int) {
        self.bgViews = MainBackgroundColors(parentView: bgView)
        if let bgs: MainBackgroundColors = self.bgViews {
            bgs.append(index: 0, color: bgs.red)
            bgs.append(index: 2, color: bgs.green)
            bgs.append(index: 3, color: bgs.green)
        }
    }
    
    // index: 0 - 2
    private func initMenu(currentIndex: Int) {
        
        self.menus = Menus(parentView: self.view, index: currentIndex)
        
        let margin: CGFloat = 12
        let centerMargin: CGFloat = self.view.frame.width / 2 - 110
        
        // icon menu
        self.menus.append(menu: Menu(
            index: 0, type: .icon, iconName: "ic_chat_bubble", activeIconName: "ic_chat_bubble", view: leftView, constraint: [leftConstraint, leftBottomConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, -12]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: UIColor.white, size: 30.0, constraint: [margin, -12]),
                MenuStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, -12]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, 100]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, type: .icon, iconName: "ic_panorama_fish_eye_48pt", activeIconName: "ic_insert_emoticon", view: centerView, constraint: [centerConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 75.0, constraint: [margin]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: UIColor.white, size: 115.0, constraint: [margin + 50]),
                MenuStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 75.0, constraint: [margin]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 75.0, constraint: [margin - 180]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 2, type: .icon, iconName: "ic_bubble_chart", activeIconName: "ic_bubble_chart", view: rightView, constraint: [rightConstraint, rightBottomConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, 12]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: UIColor.white,size: 30.0, constraint: [margin, 12]),
                MenuStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, 12]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, -100]),
            ]
        ))
        
        // menu bar
        self.menus.append(menu: Menu(
            index: 0, type: .bar, iconName: "", activeIconName: "", view: leftBarView, constraint: [leftBarConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.5, forward: 0.0, color: UIColor.lightGray, size: 40, constraint: [centerMargin + 5]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + 70]),
                MenuStyle(thenIndex: 2, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + 70]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + 70]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, type: .bar, iconName: "", activeIconName: "", view: rightBarView, constraint: [rightBarConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + 70]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + 70]),
                MenuStyle(thenIndex: 2, delay: 0.5, forward: 0.0, color: UIColor.lightGray, size: 40, constraint: [centerMargin + 5]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + 70]),
            ]
        ))
        
        leftButton.addTarget(self, action: #selector(self.onLeftButton(_:)), for: .touchDown)
        centerButton.addTarget(self, action: #selector(self.onCenterButton(_:)), for: .touchDown)
        rightButton.addTarget(self, action: #selector(self.onRightButton(_:)), for: .touchDown)
        
        // 長押し
        centerButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.onPressingCenterButton(_:))))
    }
    
    
    private func initDebugButton() {
        debugLeftButton.addTarget(self, action: #selector(self.onDebugLeftButton(_:)), for: .touchDown)
        debugRightButton.addTarget(self, action: #selector(self.onDebugRightButton(_:)), for: .touchDown)
    }
    
    
    private func initVcCallback() {
        
        let vc0: FirstViewController = self.pvc.getVc(index: 0) as! FirstViewController
        let vc2: ThirdViewController = self.pvc.getVc(index: 2) as! ThirdViewController
        
        vc0.controlMenuCallback = {
            self.debugInactive(index: 0)
        }
        vc2.controlMenuCallback = {
            self.debugInactive(index: 2)
        }
    }
    
    
    private func debugActive(index: Int) {
        if let i: Int = self.pvc.currentIndex() {
            if i != index {
                self.menus.active(index: index)
            }
        }
    }
    
    
    private func debugInactive(index: Int) {
        if let i: Int = self.pvc.currentIndex() {
            if i == index {
                self.menus.inactive(index: index)
            }
        }
    }
    
    
    // MARK: - Target Button
    
    @objc func onLeftButton(_ sender: UIButton) {
        self.pvc.onMenuButton(index: 0)
    }
    
    @objc func onCenterButton(_ sender: UIButton) {
        self.pvc.onMenuButton(index: 1)
    }
    
    @objc func onRightButton(_ sender: UIButton) {
        self.pvc.onMenuButton(index: 2)
    }
    
    @objc func onDebugLeftButton(_ sender: UIButton) {
        self.debugActive(index: 0)
    }
    
    @objc func onDebugRightButton(_ sender: UIButton) {
        self.debugActive(index: 2)
    }
    
    @objc func onPressingCenterButton(_ sender: UIButton) {
        switch sender.state.rawValue {
        case 1:// start
            self.debugActive(index: 1)
        case 2:// pressing
            break
        case 3:// end
            break
        default:
            break
        }
    }
    
}

