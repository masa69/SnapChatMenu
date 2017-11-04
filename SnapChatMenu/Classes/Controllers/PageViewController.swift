
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    
    var currentVc: Vc = .second
    var nextVc: Vc?
    
    var isProgress: Bool = true
    var scrolling: ((_ progress: CGFloat) -> Void)?
    
    private var direction: ScrollDirection = .none
    private var needUpdateVc: Bool = false
    
    
    private var menus: [(key: Vc, vc: UIViewController?)] = [
        (.first, nil),
        (.second, nil),
        (.third, nil),
    ]
    
    
    enum Vc: String {
        case first = "First"
        case second = "Second"
        case third = "Third"
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
    
    
    private func getIndex(viewController: UIViewController) -> Int? {
        var target: Vc?
        switch viewController {
        case is FirstViewController:
            target = .first
        case is SecondViewController:
            target = .second
        case is ThirdViewController:
            target = .third
        default:
            return nil
        }
        if let targetMenu: Vc = target {
            for (i, menu) in self.menus.enumerated() {
                if menu.key == targetMenu {
                    return i
                }
            }
        }
        return nil
    }
    
    
    private func currentIndex() -> Int? {
        for (i, menu) in menus.enumerated() {
            if menu.key == self.currentVc {
                return i
            }
        }
        return nil
    }
    
    
    private func getVc() -> UIViewController {
        if self.menus[self.currentVc.hashValue].vc == nil {
            let storyboard: UIStoryboard = UIStoryboard(name: self.currentVc.rawValue, bundle: nil)
            self.menus[self.currentVc.hashValue].vc = storyboard.instantiateInitialViewController()
        }
        return self.menus[self.currentVc.hashValue].vc!
    }
    
    
    private func getVc(index: Int) -> UIViewController? {
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
        
        self.isProgress = true
        
        let baseX: CGFloat = self.view.frame.width
        let x: CGFloat = scrollView.contentOffset.x
        
        var progress: CGFloat = 0
        
        if x > baseX {
            if self.currentVc == self.menus.last?.key {
                // 右端のスクロールを止める制御
                let offset: CGPoint = CGPoint(x: baseX, y: 0)
                scrollView.setContentOffset(offset, animated: false)
            }
            self.direction = .forward
            progress = (x - baseX) / baseX
        } else if x < baseX {
            if self.currentVc == self.menus.first?.key {
                // 左端のスクロールを止める制御
                let offset: CGPoint = CGPoint(x: baseX, y: 0)
                scrollView.setContentOffset(offset, animated: false)
            }
            self.direction = .reverse
            progress = (x - baseX) * -1 / baseX
        }
        
        progress = progress.percent(depth: 2)
        
        self.scrolling?(progress)
        
        if progress >= 1 || progress == 0 {
            if self.needUpdateVc {
                if let index: Int = self.currentIndex() {
                    switch self.direction {
                    case .forward:
                        self.currentVc = self.menus[index + 1].key
                    case .reverse:
                        self.currentVc = self.menus[index - 1].key
                    case .none:
                        break
                    }
                }
            }
            self.direction = .none
            self.needUpdateVc = false
            self.isProgress = false
            
            print(self.currentVc.rawValue)
        } else {
            self.needUpdateVc = (progress > 0.5) ? true : false
        }
    }
    
}
