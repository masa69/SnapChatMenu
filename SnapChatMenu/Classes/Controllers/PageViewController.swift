
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    
    var currentVc: Vc = .second
    var nextVc: Vc?
    
    var scrolling: ((_ progress: CGFloat) -> Void)?

    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([self.getVc()], direction: .forward, animated: false) { (finished: Bool) in
            //
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
    
    
    private func getIndex(vc: UIViewController) -> Int? {
        var target: Vc?
        switch vc {
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
            for menu in self.menus {
                if menu.key == targetMenu {
                    return menu.key.hashValue
                }
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
    
    private var preX: CGFloat?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(self.currentVc)
        let baseX: CGFloat = self.view.frame.width
        let x: CGFloat = scrollView.contentOffset.x
        var progress: CGFloat = 0
//        print(scrollView.contentOffset.x)
        
        if x > baseX {
            progress = (x - baseX) / baseX
            print(progress)
        } else if x < baseX {
            progress = (x - baseX) * -1 / baseX
            print(progress)
        }
        if x == baseX {
            print("update")
        }
        
        
        self.preX = x
        
        /*if self.currentVc.hashValue == 0 {
            // 左端のスクロールを止める制御
            if self.view.frame.width >= scrollView.contentOffset.x {
                let offset: CGPoint = CGPoint(x: self.view.frame.width, y: 0)
                scrollView.setContentOffset(offset, animated: false)
            }
        } else if self.currentVc.hashValue == self.menus.last?.key.hashValue {
            // 右端のスクロールを止める制御
            if self.view.frame.width <= scrollView.contentOffset.x {
                let offset: CGPoint = CGPoint(x: self.view.frame.width, y: 0)
                scrollView.setContentOffset(offset, animated: false)
            }
        }*/
    }
    
}
