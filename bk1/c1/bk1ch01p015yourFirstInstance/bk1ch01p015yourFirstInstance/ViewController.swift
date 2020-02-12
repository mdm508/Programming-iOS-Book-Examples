

import UIKit
import Swift

let sss : NSString = "howdy"

let gOne = 1
var gTwo = 2
//#1 why is this not legal
// gTwo = gOne // "Expressions are not allowed at the top level"

class Dog {
    func bark() {
        print("woof")
    }
}

class Dog2 { func bark() { print("woof") }}

//#2 what effect will this extension to Int have?
extension Int {
    func sayHello() {
        print("Hello, I'm \(self)")
    }
}

func go() {
    let one = 1
    var two = 2
    two = one
    let _ = (one,two) //#3 what does this line do?
    
    let three = 3
    // three = one // compile error #4 why is this a compile error
    _ = three
}

func doGo() {
    go()
}

// let class = 1 // Keyword 'class' cannot be used as an identifier here
// func if() { } // Keyword 'if' cannot be used as an identifier here
class `func` {
    func `if`() {
        let `class` = 1
        _ = `class`
    }
}

//#5 what is so silly about this funciton?
func silly() {
    if true {
        class Cat {}
        var one = 1
        one = one + 1
    }
}


//#5 define a cat class with one method called 'meow' which returns a string
//#6 add an extension to string class. create method called 'prependHashTag' that adds a hash
//tags before the string. Hint use self
extension String {
}

class ViewController: UIViewController {
    
    // gTwo = gOne // "Expected declaration"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        print("hello")
        print("world")
        print("hello"); print("world")
        print("hello");
        print("world");
        print(
        "world")
        print("world") // this is a comment, so Swift ignores it
        
        let sum = 1 + 2
        let s = 1.description
        
        _ = sum
        _ = s
        
        1.sayHello() // outputs: "Hello, I'm 1"

        let one = 1
        var two = 2
        two = one
        // one = two // compile error
        // two = "hello" // compile error

        
        var three = 3 // compiler warns, new in Swift 2.0
        
        let _ = (one, two, three)

        
        let fido = Dog()
        fido.bark()

        // Dog.bark() // error: no, it's an _instance_ method
        // think the error message is weird? see the explanation on p. 127
        
        let rover = Dog.init()
        rover.bark()
        
        /*
        let my_string = "cats for life"
        print(my_string.prependHashTag())
        */
        
    }



}

