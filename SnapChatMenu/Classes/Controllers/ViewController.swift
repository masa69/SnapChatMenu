
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bgView: TransparentView!
    
    // header
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerTitleLabel: UILabel!
    @IBOutlet weak var centerTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightSideTitleLabel: UILabel!
    @IBOutlet weak var rightSideTitleConstraint: NSLayoutConstraint!
    
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
    @IBOutlet weak var debugLeftButton: DefaultButton!
    @IBOutlet weak var debugRightButton: DefaultButton!
    
    
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
        let centerMarginAjust: CGFloat = self.view.frame.width / 2 * 0.6
        let centerMargin: CGFloat = self.view.frame.width / 2 - centerMarginAjust
        
        // header label
        leftTitleLabel.text = "Title 1"
        centerTitleLabel.text = "Title 2"
        rightTitleLabel.text = "Title 3"
        rightSideTitleLabel.text = "Title 4"
        
        leftTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 24.0)
        centerTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 24.0)
        rightTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 24.0)
        rightSideTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 24.0)
        
        self.menus.append(menu: Menu(
            index: 0, type: .text, label: leftTitleLabel, constraint: [leftTitleConstraint],
            styles: [
                MenuStyle(thenIndexForLabel: 0, delay: 0.5, forward: 0.0, color: UIColor.white, constraint: [0]),
                MenuStyle(thenIndexForLabel: 1, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 2, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 3, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, type: .text, label: centerTitleLabel, constraint: [centerTitleConstraint],
            styles: [
                MenuStyle(thenIndexForLabel: 0, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 1, delay: 0.5, forward: 0.0, color: UIColor.white, border: .shadow, constraint: [0]),
                MenuStyle(thenIndexForLabel: 2, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 3, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 2, type: .text, label: rightTitleLabel, constraint: [rightTitleConstraint],
            styles: [
                MenuStyle(thenIndexForLabel: 0, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 1, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 2, delay: 0.5, forward: 0.0, color: UIColor.white, constraint: [0]),
                MenuStyle(thenIndexForLabel: 3, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 0, type: .text, label: rightSideTitleLabel, constraint: [rightSideTitleConstraint],
            styles: [
                MenuStyle(thenIndexForLabel: 0, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 1, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 2, delay: 0.0, forward: 0.6, color: UIColor.clear, constraint: [-20]),
                MenuStyle(thenIndexForLabel: 3, delay: 0.5, forward: 0.0, color: UIColor.black, constraint: [0]),
            ]
        ))
        
        // icon menu
        self.menus.append(menu: Menu(
            index: 0, key: "leftMenu", type: .icon, iconName: "ic_chat_bubble", activeIconName: "ic_chat_bubble", view: leftView, constraint: [leftConstraint, leftBottomConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, margin]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: UIColor.white, border: .shadow, size: 30.0, constraint: [margin, margin]),
                MenuStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, margin]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, -100]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, type: .icon, iconName: "record", activeIconName: "record", view: centerView, constraint: [centerConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 75.0, constraint: [margin]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: UIColor.white, border: .shadow, size: 115.0, constraint: [margin + 50]),
                MenuStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 75.0, constraint: [margin]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 75.0, constraint: [margin - 180]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 2, key: "rightMenu", type: .icon, iconName: "ic_bubble_chart", activeIconName: "ic_bubble_chart", view: rightView, constraint: [rightConstraint, rightBottomConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, margin]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: UIColor.white, border: .shadow,size: 30.0, constraint: [margin, margin]),
                MenuStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, margin]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: UIColor.lightGray, size: 24.0, constraint: [centerMargin, -100]),
            ]
        ))
        
        // menu bar
        self.menus.append(menu: Menu(
            index: 0, type: .bar, iconName: "", activeIconName: "", view: leftBarView, constraint: [leftBarConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.5, forward: 0.0, color: UIColor.lightGray, size: 40, constraint: [centerMargin + 5]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
                MenuStyle(thenIndex: 2, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, type: .bar, iconName: "", activeIconName: "", view: rightBarView, constraint: [rightBarConstraint],
            styles: [
                MenuStyle(thenIndex: 0, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
                MenuStyle(thenIndex: 1, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
                MenuStyle(thenIndex: 2, delay: 0.5, forward: 0.0, color: UIColor.lightGray, size: 40, constraint: [centerMargin + 5]),
                MenuStyle(thenIndex: 3, delay: 0.0, forward: 0.5, color: UIColor.clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
            ]
        ))
        
        leftButton.touchDown = {
            self.pvc.onMenuButton(index: 0)
        }
        
        centerButton.touchDown = {
            self.pvc.onMenuButton(index: 1)
        }
        
        rightButton.touchDown = {
            self.pvc.onMenuButton(index: 2)
        }
        
        // 長押し
        centerButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.onPressingCenterButton(_:))))
    }
    
    
    private func initDebugButton() {
        
        debugLeftButton.touchDown = {
            self.active(index: 0)
        }
        
        debugRightButton.touchDown = {
            self.active(index: 2)
        }
        
    }
    
    
    private func initVcCallback() {
        
        let vc0: FirstViewController = self.pvc.getVc(index: 0) as! FirstViewController
        let vc2: ThirdViewController = self.pvc.getVc(index: 2) as! ThirdViewController
        
        vc0.controlMenuCallback = {
            self.inactive(index: 0)
        }
        vc2.controlMenuCallback = {
            self.inactive(index: 2)
        }
    }
    
    
    private func active(index: Int) {
        if let i: Int = self.pvc.currentIndex() {
            if i != index {
                self.menus.active(index: index)
            }
        }
        if self.pvc.currentVc == .second {
            self.menus.active(index: index)
        }
    }
    
    
    private func inactive(index: Int) {
        if let i: Int = self.pvc.currentIndex() {
            if i == index {
                self.menus.inactive(index: index)
            }
        }
        if self.pvc.currentVc == .second {
            self.menus.inactive(index: index)
        }
    }
    
    
    // MARK: - Gesture Recognizer
    
    @objc func onPressingCenterButton(_ sender: UIButton) {
        switch sender.state.rawValue {
        case 1:// start
            print("pressing start")
            self.active(index: 1)
        case 2:// pressing
            break
        case 3:// end
            print("pressing end")
            self.inactive(index: 1)
        default:
            break
        }
    }
    
}

