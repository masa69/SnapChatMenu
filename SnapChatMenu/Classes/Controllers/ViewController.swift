
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
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
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftButton: TransparentButton!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var centerButton: TransparentButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightButton: TransparentButton!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightBottomConstraint: NSLayoutConstraint!
    
    // global menu bar
    @IBOutlet weak var leftBarView: UIView!
    @IBOutlet weak var leftBarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightBarView: UIView!
    @IBOutlet weak var rightBarConstraint: NSLayoutConstraint!
    
    // debug button
    @IBOutlet weak var debugLeftButton: DefaultButton!
    @IBOutlet weak var debugRightButton: DefaultButton!
    
    
    var pvc: PageViewController!
    
    var animations: PVCAnimations!
    
    var bgAnimations: PVCBackgroundAnimations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        
        self.initPvc()
        if let currentIndex: Int = self.pvc.currentIndex() {
            self.initPVCAnimation(currentIndex: currentIndex)
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
            self.initPVCBackgroundAnimation(currentIndex: currentIndex)
        }
    }
    
    
    private func initPvc() {
        self.pvc = self.childViewControllers[0] as! PageViewController
        self.pvc.scrolling = { (progress: CGFloat, from: Int, to: Int) in
            self.bgAnimations?.action(progress: progress, from: from, to: to)
            self.animations.action(progress: progress, from: from, to: to)
        }
    }
    
    
    private func initPVCBackgroundAnimation(currentIndex: Int) {
        self.bgAnimations = PVCBackgroundAnimations(parentView: bgView)
        if let bgs: PVCBackgroundAnimations = self.bgAnimations {
            bgs.append(index: 0, color: bgs.red)
            bgs.append(index: 2, color: bgs.green)
            bgs.append(index: 3, color: bgs.green)
        }
    }
    
    // index: 0 - 2
    private func initPVCAnimation(currentIndex: Int) {
        
        self.animations = PVCAnimations(parentView: self.view, index: currentIndex)
        
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
        
        self.animations.append(animation: PVCAnimation(
            index: 0, type: .text, label: leftTitleLabel, constraint: [leftTitleConstraint],
            styles: [
                PVCAnimationStyle(thenIndexForLabel: 0, delay: 0.5, forward: 0.0, color: .white, constraint: [0]),
                PVCAnimationStyle(thenIndexForLabel: 1, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 2, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 3, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
            ]
        ))
        self.animations.append(animation: PVCAnimation(
            index: 1, type: .text, label: centerTitleLabel, constraint: [centerTitleConstraint],
            styles: [
                PVCAnimationStyle(thenIndexForLabel: 0, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 1, delay: 0.5, forward: 0.0, color: .white, border: .shadow, constraint: [0]),
                PVCAnimationStyle(thenIndexForLabel: 2, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 3, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
            ]
        ))
        self.animations.append(animation: PVCAnimation(
            index: 2, type: .text, label: rightTitleLabel, constraint: [rightTitleConstraint],
            styles: [
                PVCAnimationStyle(thenIndexForLabel: 0, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 1, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 2, delay: 0.5, forward: 0.0, color: .white, constraint: [0]),
                PVCAnimationStyle(thenIndexForLabel: 3, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
            ]
        ))
        self.animations.append(animation: PVCAnimation(
            index: 0, type: .text, label: rightSideTitleLabel, constraint: [rightSideTitleConstraint],
            styles: [
                PVCAnimationStyle(thenIndexForLabel: 0, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 1, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 2, delay: 0.0, forward: 0.6, color: .clear, constraint: [-20]),
                PVCAnimationStyle(thenIndexForLabel: 3, delay: 0.5, forward: 0.0, color: .black, constraint: [0]),
            ]
        ))
        
        // icon menu
        self.animations.append(animation: PVCAnimation(
            index: 0, key: "leftMenu", type: .icon, iconName: "ic_chat_bubble", activeIconName: "ic_chat_bubble", view: leftView, constraint: [leftConstraint, leftBottomConstraint],
            styles: [
                PVCAnimationStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: .lightGray, size: 24.0, constraint: [centerMargin, margin]),
                PVCAnimationStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: .white, border: .shadow, size: 30.0, constraint: [margin, margin]),
                PVCAnimationStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: .lightGray, size: 24.0, constraint: [centerMargin, margin]),
                PVCAnimationStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: .lightGray, size: 24.0, constraint: [centerMargin, -100]),
            ]
        ))
        self.animations.append(animation: PVCAnimation(
            index: 1, type: .icon, iconName: "record", activeIconName: "record", view: centerView, constraint: [centerConstraint],
            styles: [
                PVCAnimationStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: .lightGray, size: 75.0, constraint: [margin]),
                PVCAnimationStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: .white, border: .shadow, size: 115.0, constraint: [margin + 50]),
                PVCAnimationStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: .lightGray, size: 75.0, constraint: [margin]),
                PVCAnimationStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: .lightGray, size: 75.0, constraint: [margin - 180]),
            ]
        ))
        self.animations.append(animation: PVCAnimation(
            index: 2, key: "rightMenu", type: .icon, iconName: "ic_bubble_chart", activeIconName: "ic_bubble_chart", view: rightView, constraint: [rightConstraint, rightBottomConstraint],
            styles: [
                PVCAnimationStyle(thenIndex: 0, delay: 0.0, forward: 0.0, color: .lightGray, size: 24.0, constraint: [centerMargin, margin]),
                PVCAnimationStyle(thenIndex: 1, delay: 0.0, forward: 0.0, color: .white, border: .shadow,size: 30.0, constraint: [margin, margin]),
                PVCAnimationStyle(thenIndex: 2, delay: 0.0, forward: 0.0, color: .lightGray, size: 24.0, constraint: [centerMargin, margin]),
                PVCAnimationStyle(thenIndex: 3, delay: 0.0, forward: 0.0, color: .lightGray, size: 24.0, constraint: [centerMargin, -100]),
            ]
        ))
        
        // menu bar
        self.animations.append(animation: PVCAnimation(
            index: 0, type: .bar, iconName: "", activeIconName: "", view: leftBarView, constraint: [leftBarConstraint],
            styles: [
                PVCAnimationStyle(thenIndex: 0, delay: 0.5, forward: 0.0, color: .lightGray, size: 40, constraint: [centerMargin + 5]),
                PVCAnimationStyle(thenIndex: 1, delay: 0.0, forward: 0.5, color: .clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
                PVCAnimationStyle(thenIndex: 2, delay: 0.0, forward: 0.5, color: .clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
                PVCAnimationStyle(thenIndex: 3, delay: 0.0, forward: 0.5, color: .clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
            ]
        ))
        self.animations.append(animation: PVCAnimation(
            index: 1, type: .bar, iconName: "", activeIconName: "", view: rightBarView, constraint: [rightBarConstraint],
            styles: [
                PVCAnimationStyle(thenIndex: 0, delay: 0.0, forward: 0.5, color: .clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
                PVCAnimationStyle(thenIndex: 1, delay: 0.0, forward: 0.5, color: .clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
                PVCAnimationStyle(thenIndex: 2, delay: 0.5, forward: 0.0, color: .lightGray, size: 40, constraint: [centerMargin + 5]),
                PVCAnimationStyle(thenIndex: 3, delay: 0.0, forward: 0.5, color: .clear, size: 5, constraint: [centerMargin + centerMarginAjust * 0.7]),
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
        
        vc0.viewDidAppearCallback = {
            self.inactive(index: 0)
        }
        
        vc2.viewDidAppearCallback = {
            self.inactive(index: 2)
        }
        
    }
    
    
    private func active(index: Int) {
        if let i: Int = self.pvc.currentIndex() {
            if i != index {
                self.animations.active(index: index)
            }
        }
        if self.pvc.currentVc == .second {
            self.animations.active(index: index)
        }
    }
    
    
    private func inactive(index: Int) {
        if let i: Int = self.pvc.currentIndex() {
            if i == index {
                self.animations.inactive(index: index)
            }
        }
        if self.pvc.currentVc == .second {
            self.animations.inactive(index: index)
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

