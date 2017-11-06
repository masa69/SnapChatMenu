
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bgView: TransparentView!
    
    @IBOutlet weak var leftView: TransparentView!
    @IBOutlet weak var leftButton: TransparentButton!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var centerView: TransparentView!
    @IBOutlet weak var centerButton: TransparentButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightView: TransparentView!
    @IBOutlet weak var rightButton: TransparentButton!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    
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
    
    
    private func initMenu(currentIndex: Int) {
        
        self.menus = Menus(parentView: self.view, index: currentIndex)
        // index: 0 - 2
        
        let margin: CGFloat = 12
        let centerMargin: CGFloat = self.view.frame.width / 2 - 110
        
        self.menus.append(menu: Menu(
            index: 0, iconName: "ic_chat_bubble", view: leftView, constraint: leftConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, size: 24.0, constraint: centerMargin),
                MenuStyle(thenIndex: 1, color: UIColor.white, size: 30.0, constraint: margin),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, size: 24.0, constraint: centerMargin),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 1, iconName: "ic_panorama_fish_eye_48pt", view: centerView, constraint: centerConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, size: 75.0, constraint: margin),
                MenuStyle(thenIndex: 1, color: UIColor.white, size: 115.0, constraint: margin + 50),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, size: 75.0, constraint: margin),
            ]
        ))
        self.menus.append(menu: Menu(
            index: 2, iconName: "ic_bubble_chart", view: rightView, constraint: rightConstraint,
            styles: [
                MenuStyle(thenIndex: 0, color: UIColor.lightGray, size: 24.0, constraint: centerMargin),
                MenuStyle(thenIndex: 1, color: UIColor.white,size: 30.0, constraint: margin),
                MenuStyle(thenIndex: 2, color: UIColor.lightGray, size: 24.0, constraint: centerMargin),
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

