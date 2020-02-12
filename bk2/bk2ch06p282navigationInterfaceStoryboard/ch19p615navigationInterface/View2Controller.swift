
import UIKit

class View2Controller : UIViewController {
        
    // we're now coming out of a nib, must implement init(coder:), may as well configure here
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.title = "Second"
        let b = UIBarButtonItem(image: UIImage(named:"files"), style: .plain, target: nil, action: nil)
        // can have both left bar buttons and back bar button
        self.navigationItem.leftBarButtonItem = b
        self.navigationItem.leftItemsSupplementBackButton = true
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .red // just so we know we're here
    }
    
    // with a back button, we get "pop" for free, both by tapping the button...
    // and interactively by dragging from the left edge
    
}
