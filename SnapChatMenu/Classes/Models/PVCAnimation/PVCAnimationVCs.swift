
import UIKit

class PVCAnimationVCs {
    
    let index: Int
    
    let key: Name
    
    var vc: UIViewController?
    
    
    init(index: Int, key: Name) {
        
        self.index = index
        
        self.key = key
    }
    
    
    // case xxx = "StoryboardName.ViewControllerID"
    enum Name: String {
        
        case first = "First.First"
        case second = "Second"
        case third = "Third"
        case fourth = "Fourth"
        
        static func get(vc: UIViewController) -> Name? {
            switch vc {
            case is FirstViewController:
                return .first
            case is SecondViewController:
                return .second
            case is ThirdViewController:
                return .third
            case is FourthViewController:
                return .fourth
            default:
                return nil
            }
        }
        
        static func storyboardName(name: Name) -> String {
            let subStrs: [Substring] = name.rawValue.split(separator: ".")
            return subStrs[0].toString()
        }
        
        static func viewControllerID(name: Name) -> String? {
            let subStrs: [Substring] = name.rawValue.split(separator: ".")
            return (subStrs.count == 2) ? subStrs[1].toString() : nil
        }
        
    }
    
}
