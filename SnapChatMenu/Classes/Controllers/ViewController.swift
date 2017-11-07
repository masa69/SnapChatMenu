
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bgView: TransparentView!
    
    // global menu
    @IBOutlet weak var leftView: TransparentView!
    @IBOutlet weak var leftButton: TransparentButton!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var centerView: TransparentView!
    @IBOutlet weak var centerButton: TransparentButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightView: TransparentView!
    @IBOutlet weak var rightButton: TransparentButton!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    // global menu bar
    @IBOutlet weak var leftBarView: TransparentView!
    @IBOutlet weak var leftBarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightBarView: TransparentView!
    @IBOutlet weak var rightBarConstraint: NSLayoutConstraint!
    
    
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
        }
    }
    
    // index: 0 - 2
    private func initMenu(currentIndex: Int) {
        
        self.menus = Menus(parentView: self.view, index: currentIndex)
        
        let margin: CGFloat = 12
        let centerMargin: CGFloat = self.view.frame.width / 2 - 110
        
        // icon menu
        self.menus.append(menu: Menu(
            index: 0, type: .icon, iconName: "ic_chat_bubble", delay: 0.0, forward: 0.0, view: leftView, constraint: leftConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, size: 24.0, constraint: centerMargin),
                MenuStyle(thenIndex: 1, color: UIColor.white, size: 30.0, constraint: margin),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, size: 24.0, constraint: centerMargin),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, type: .icon, iconName: "ic_panorama_fish_eye_48pt", delay: 0.0, forward: 0.0, view: centerView, constraint: centerConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, size: 75.0, constraint: margin),
                MenuStyle(thenIndex: 1, color: UIColor.white, size: 115.0, constraint: margin + 50),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, size: 75.0, constraint: margin),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 2, type: .icon, iconName: "ic_bubble_chart", delay: 0.0, forward: 0.0, view: rightView, constraint: rightConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, size: 24.0, constraint: centerMargin),
                MenuStyle(thenIndex: 1, color: UIColor.white,size: 30.0, constraint: margin),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, size: 24.0, constraint: centerMargin),
            ]
        ))
        
        // menu bar
        self.menus.append(menu: Menu(
            index: 0, type: .bar, iconName: "", delay: 0.7, forward: 0.0, view: leftBarView, constraint: leftBarConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, size: 40, constraint: centerMargin + 5),
                MenuStyle(thenIndex: 1, color: UIColor.clear, size: 5, constraint: centerMargin + 70),
                MenuStyle(thenIndex: 2, color: UIColor.clear, size: 5, constraint: centerMargin + 70),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, type: .bar, iconName: "", delay: 0.7, forward: 0.0, view: rightBarView, constraint: rightBarConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.clear, size: 5, constraint: centerMargin + 70),
                MenuStyle(thenIndex: 1, color: UIColor.clear, size: 5, constraint: centerMargin + 70),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, size: 40, constraint: centerMargin + 5),
            ]
        ))
        
        leftButton.addTarget(self, action: #selector(self.onLeftButton(_:)), for: .touchDown)
        centerButton.addTarget(self, action: #selector(self.onCenterButton(_:)), for: .touchDown)
        rightButton.addTarget(self, action: #selector(self.onRightButton(_:)), for: .touchDown)
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
    
}

