

import UIKit

class SecondViewController: UIViewController {

    override func allowedChildrenForUnwinding(from source: UIStoryboardUnwindSegueSource) -> [UIViewController] {
        let result = super.allowedChildrenForUnwinding(from: source)
        print("\(type(of:self)) \(#function) \(result)")
        return result
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        print("\(type(of:self)) \(#function) \(subsequentVC)")
        super.unwind(for: unwindSegue, towards: subsequentVC)
    }
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, sender: Any?) -> Bool {
        let result = super.canPerformUnwindSegueAction(action, from: fromViewController, sender: sender)
        print("\(type(of:self)) \(#function) \(action) \(result)")
        return result
    }
    
    override func dismiss(animated: Bool, completion: (() -> Void)?) {
        print("\(type(of:self)) \(#function)")
        super.dismiss(animated:animated, completion: completion)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let result = super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        if identifier == "unwind" {
            print("\(type(of:self)) \(#function) \(result)")
        }
        return result
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind" {
            print("\(type(of:self)) \(#function)")
        }
    }


}

