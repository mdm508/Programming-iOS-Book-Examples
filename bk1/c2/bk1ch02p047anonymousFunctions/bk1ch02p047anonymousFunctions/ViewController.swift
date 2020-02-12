

import UIKit

func doThis(f:()->()) {
    f()
}

func greeting() -> String {
    return "Howdy"
}
func performAndPrint(_ f:()->String) {
    let s = f()
    print(s)
}

func imageOfSize(_ size:CGSize, _ whatToDraw:() -> ()) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    whatToDraw()
    let result = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return result
}

func test(h:(Int, Int, Int) -> Int) {
    
}



class ViewController: UIViewController {

    @IBOutlet weak var myButton2: UIButton!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = imageOfSize(CGSize(width:45, height:20), {
            () -> () in // included deliberately for book example
            let p = UIBezierPath(
                roundedRect: CGRect(x:0,y:0,width:45,height:20),
                cornerRadius: 8)
            p.stroke()
        })
        
        test {
            // _ in // showing that _ can mean "ignore _all_ parameters"
            // okay, again, that's no longer legal, and for the same reason as the (Void):
            // you can no longer slide between 3 params and 1 tuple
            _,_,_ in
            return 0
        }

        
        doThis { // no parentheses!
            print("Howdy")
        }
        
        performAndPrint {
            greeting() // meaning: return greeting()
        }
        
        

        let arr = [2, 4, 6, 8]
        
        func doubleMe(i:Int) -> Int {
            return i*2
        }
        let arr2 = arr.map(doubleMe) // [4, 8, 12, 16]
        print(arr2)
        
        let arr3 = arr.map ({
            (i:Int) -> Int in
            return i*2
        })
        print(arr3)
        
        let arr4 = arr.map {$0*2} // it doesn't get any Swiftier than this
        print(arr4)
        
        // however, you can't use trailing closures directly before curly braces
        
//        for i in arr.map {$0*2} { // Trailing closure requires parentheses for disambiguation in this context
//            print(i)
//        }

        for i in (arr.map {$0*2}) {
            print(i)
        }
        
        _ = arr.map{$0*2}.first == 4
        
//        if arr.map {$0*2}.first == 4 { // spew of meaningless error messages
//            print("yup")
//        }

        if (arr.map {$0*2}.first) == 4 {
            print("yup")
        }

    }

    @IBAction func doButton(_ sender: Any) {
        
        
        UIView.animate(withDuration:0.4,
            animations: {
                () -> () in
                self.myButton.frame.origin.y += 20
            }, completion: {
                (finished:Bool) -> () in
                print("finished: \(finished)")
        })

        
    }
    
    @IBAction func doButton2(_ sender: Any) {
        
        // showing some serious compression of the above syntax
        
        UIView.animate(withDuration:0.4,
            animations: {
                self.myButton2.frame.origin.y += 20
            }) {
                print("finished: \($0)") // must have either "_ in" or "$0"
        }
        
        UIView.animate(withDuration:0.4,
            animations: {
                self.myButton2.frame.origin.y += 20
            }) { _ in
                print("finished") // must have either "_ in" or "$0"
        }
        
        
    }
    


}

