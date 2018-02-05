
import UIKit

struct PVCAnimationVcs {
    
    let index: Int
    
    let key: ViewControllers.Name
    
    var vc: UIViewController?
    
    
    init(index: Int, key: ViewControllers.Name) {
        
        self.index = index
        
        self.key = key
    }
    
}

class PVCAnimationPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    var currentVc: ViewControllers.Name!
    
    var menus: [PVCAnimationVcs]!
    
    var isProgress: Bool = true
    
    var scrolling: ((_ progress: CGFloat, _ from: Int, _ to: Int) -> Void)?
    
    var didChangeVc: (() -> Void)?
    
    private var direction: ScrollDirection = .none
    private var needUpdateVc: Bool = false
    private var nextIndex: Int?
    private var preProgress: CGFloat = 0
    
    
    enum ScrollDirection {
        case none
        case forward
        case reverse
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initScroll()
        self.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func initScroll() {
        // UIPageViewController でスクロールを検知する
        for v in self.view.subviews {
            if let scroll = v as? UIScrollView {
                scroll.delegate = self
            }
        }
    }
    
    
    func configure(defaultVc: ViewControllers.Name, menus: [PVCAnimationVcs]) {
        
        self.currentVc = defaultVc
        self.menus = menus
        
        if let vc: UIViewController = self.getVc() {
            self.setViewControllers([vc], direction: .forward, animated: false) { (finished: Bool) in
                self.isProgress = false
            }
        }
    }
    
    
    func onMenuButton(index: Int) {
        if self.isProgress {
            return
        }
        guard let current: Int = self.currentIndex() else {
            return
        }
        if current == index {
            return
        }
        self.move(from: current, to: index)
    }
    
    
    private func move(from: Int, to: Int) {
        if let vc: UIViewController = self.getVc(index: to) {
            // タップを不能にする
            if !UIApplication.shared.isIgnoringInteractionEvents {
                UIApplication.shared.beginIgnoringInteractionEvents()
            }
            let direction: UIPageViewControllerNavigationDirection = (from < to) ? .forward : .reverse
            self.nextIndex = to
            self.setViewControllers([vc], direction: direction, animated: true) { (finished: Bool) in
                // タップを可能にする
                if UIApplication.shared.isIgnoringInteractionEvents {
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
        }
    }
    
    private func getIndex(vc: UIViewController) -> Int? {
        if let key: ViewControllers.Name = ViewControllers.Name.get(vc: vc) {
            for menu in self.menus {
                if menu.key == key {
                    return menu.index
                }
            }
        }
        return nil
    }
    
    
    func currentIndex() -> Int? {
        for menu in self.menus {
            if menu.key == self.currentVc {
                return menu.index
            }
        }
        return nil
    }
    
    
    func getVc() -> UIViewController? {
        guard let index: Int = self.currentIndex() else {
            return nil
        }
        if self.menus[index].vc == nil {
            let storyboard: UIStoryboard = UIStoryboard(name: ViewControllers.Name.storyboardName(name: self.currentVc), bundle: nil)
            if let vcId: String = ViewControllers.Name.viewControllerID(name: self.currentVc) {
                self.menus[index].vc = storyboard.instantiateViewController(withIdentifier: vcId)
            } else {
                self.menus[index].vc = storyboard.instantiateInitialViewController()
            }
        }
        return self.menus[index].vc!
    }
    
    
    func getVc(index: Int) -> UIViewController? {
        if 0 <= index && index < self.menus.count {
            if self.menus[index].vc == nil {
                let storyboard: UIStoryboard = UIStoryboard(name: ViewControllers.Name.storyboardName(name: self.menus[index].key), bundle: nil)
                if let vcId: String = ViewControllers.Name.viewControllerID(name: self.menus[index].key) {
                    self.menus[index].vc = storyboard.instantiateViewController(withIdentifier: vcId)
                } else {
                    self.menus[index].vc = storyboard.instantiateInitialViewController()
                }
            }
            return self.menus[index].vc!
        }
        return nil
    }
    
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index: Int = self.getIndex(vc: viewController) else {
            return nil
        }
        return self.getVc(index: index + 1)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index: Int = self.getIndex(vc: viewController) else {
            return nil
        }
        return self.getVc(index: index - 1)
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let index: Int = self.currentIndex() else {
            return
        }
        guard let lastIndex: Int = self.menus.last?.index else {
            return
        }
        
        self.isProgress = true
        
        let baseX: CGFloat = self.view.frame.width
        let x: CGFloat = scrollView.contentOffset.x
        
        var progress: CGFloat = 0
        var nextIndex: Int = index
        
        if x > baseX {
            if self.currentVc == self.menus.last?.key {
                // 右端のスクロールを止める制御
                let offset: CGPoint = CGPoint(x: baseX, y: 0)
                scrollView.setContentOffset(offset, animated: false)
            }
            self.direction = .forward
            progress = (x - baseX) / baseX
            nextIndex = (nextIndex + 1 > lastIndex) ? lastIndex : nextIndex + 1
        } else if x < baseX {
            if self.currentVc == self.menus.first?.key {
                // 左端のスクロールを止める制御
                let offset: CGPoint = CGPoint(x: baseX, y: 0)
                scrollView.setContentOffset(offset, animated: false)
            }
            self.direction = .reverse
            progress = (x - baseX) * -1 / baseX
            nextIndex = (nextIndex - 1 < 0) ? 0 : nextIndex - 1
        }
        
        if let ni: Int = self.nextIndex {
            nextIndex = ni
        }
//        print("x: \(x)")
        progress = progress.percent(depth: 2)
        progress = (progress > 1) ? 1 : progress
        
        // 画面端から素早くスワイプすると x が上限、下限を超えてしまうので制御する
        if self.preProgress == 1 {
            if progress == 1 {
                self.needUpdateVc = false
            }
        }
        
        if progress == 0 || progress == 1 {
//            print("complete")
            if self.needUpdateVc {
                if self.nextIndex == nil {
                    switch self.direction {
                    case .forward:
                        nextIndex = index + 1
                    case .reverse:
                        nextIndex = index - 1
                    case .none:
                        break
                    }
                }
                self.currentVc = self.menus[nextIndex].key
                self.needUpdateVc = false
                self.didChangeVc?()
            }
            self.direction = .none
            self.nextIndex = nil
            self.isProgress = false
        } else {
            self.needUpdateVc = (progress > 0.5) ? true : false
        }
//        print(progress, index, nextIndex)
        if self.preProgress == 1 && progress == 1 {
            // タップを不能にする
            if !UIApplication.shared.isIgnoringInteractionEvents {
                print("begin ignore")
                UIApplication.shared.beginIgnoringInteractionEvents()
            }
            self.preProgress = progress
            print("stop")
            return
        }
        if progress == 0 {
            // タップを可能にする
            if UIApplication.shared.isIgnoringInteractionEvents {
                print("end ignore")
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        
        self.preProgress = progress
        
        self.scrolling?(progress, index, nextIndex)
    }
    
}
