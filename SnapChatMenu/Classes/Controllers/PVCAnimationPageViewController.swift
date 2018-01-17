
import UIKit

class PVCAnimationPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    var currentVc: Vc = .second
    
    var isProgress: Bool = true
    var scrolling: ((_ progress: CGFloat, _ from: Int, _ to: Int) -> Void)?
    
    private var direction: ScrollDirection = .none
    private var needUpdateVc: Bool = false
    private var nextIndex: Int?
    private var preProgress: CGFloat = 0
    
    private var menus: [(index: Int, key: Vc, vc: UIViewController?)] = [
        (0, .first, nil),
        (1, .second, nil),
        (2, .third, nil),
        (3, .fourth, nil),
        ]
    
    
    // case xxx = "ストーリーボード名"
    enum Vc: String {
        case first = "First"
        case second = "Second"
        case third = "Third"
        case fourth = "Fourth"
    }
    
    
    enum ScrollDirection {
        case none
        case forward
        case reverse
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([self.getVc()], direction: .forward, animated: false) { (finished: Bool) in
            self.isProgress = false
        }
        // UIPageViewController でスクロールを検知する
        for v in self.view.subviews {
            if let scroll = v as? UIScrollView {
                scroll.delegate = self
            }
        }
        self.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    private func getIndex(viewController: UIViewController) -> Int? {
        var target: Vc?
        switch viewController {
        case is FirstViewController:
            target = .first
        case is SecondViewController:
            target = .second
        case is ThirdViewController:
            target = .third
        case is FourthViewController:
            target = .fourth
        default:
            return nil
        }
        if let targetMenu: Vc = target {
            for menu in self.menus {
                if menu.key == targetMenu {
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
    
    
    private func getVc() -> UIViewController {
        guard let index: Int = self.currentIndex() else {
            return UIViewController()
        }
        if self.menus[index].vc == nil {
            let storyboard: UIStoryboard = UIStoryboard(name: self.currentVc.rawValue, bundle: nil)
            self.menus[index].vc = storyboard.instantiateInitialViewController()
        }
        return self.menus[index].vc!
    }
    
    
    func getVc(index: Int) -> UIViewController? {
        if 0 <= index && index < self.menus.count {
            if self.menus[index].vc == nil {
                let storyboard: UIStoryboard = UIStoryboard(name: self.menus[index].key.rawValue, bundle: nil)
                self.menus[index].vc = storyboard.instantiateInitialViewController()
            }
            return self.menus[index].vc!
        }
        return nil
    }
    
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index: Int = self.getIndex(viewController: viewController) else {
            return nil
        }
        return self.getVc(index: index + 1)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index: Int = self.getIndex(viewController: viewController) else {
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
                print("update")
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
