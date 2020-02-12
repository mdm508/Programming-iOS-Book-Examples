

import UIKit

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}


// observed object must derive from NSObject
class Observed : NSObject {
    // absolutely crucial to say "dynamic" or this won't work (and now objc too)
    @objc dynamic var value : Bool = false
    deinit {
        print("farewell from MyClass1")
    }
}

// the observer no longer has to derive from NSObject, or even be a class instance!
// that's because it isn't the observer; the real observer is the NSKeyValueObservation object
class Observer {
    
// failed experiment
    
//    func registerWith(_ mc : MyClass1, keyPath : PartialKeyPath<MyClass1>) {
//        let opts : NSKeyValueObservingOptions = [.new, .old]
//        mc.observe(keyPath, options: opts) { a, b in }
//    }
    
    var obs = Set<NSKeyValueObservation>()
    
    func registerWith(_ observed:Observed) {
        let opts : NSKeyValueObservingOptions = [.old, .new]
        let ob = observed.observe(\.value, options: opts) { obj, change in
            // obj is the observed object
            // change is an NSKeyValueObservedChange
            if let oldValue = change.oldValue {
                print("old value was \(oldValue)")
            }
            if let newValue = change.newValue {
                print("new value is \(newValue)")
            }
            // but is there a danger of a retain cycle???? to find out, let's refer to self
            print(self)
            // yes, we can leak if we don't say unowned self
        }
        // the observer must live long enough for the function to be executed
        obs.insert(ob)
    }

    
    
    deinit {
        print("farewell from MyClass2")
    }

    
}

private var con = "ObserveValue"

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var observed : Observed!
    var observer : Observer!
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    
        self.window = self.window ?? UIWindow()
        self.window!.rootViewController = UIViewController()
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        
        
        
        observed = Observed()
        observer = Observer()
        // step one: registration
        let kp = \Observed.value
        observer.registerWith(observed)
        
        // step two: make a change in a KVO compatible way
        observed.value = true
        
        // look ma, no memory management! no unregistration!
        // I can safely destroy one or both objects, in either order
        // no crash, even if the observer doesn't exist when the value changes
        
        var which : Int { return 1 }
        switch which {
        case 0:
            // A then B
            observed = nil
            observer = nil
            // but that _will_ crash in iOS 10 or before!
        case 1:
            // B then A, with observed change
            observer = nil
            // ha ha! when objectB goes out of existence, so does the observer!
            // thus the observation stops
            observed.value = false
            observed = nil
            // but that last line will crash in iOS 10 if the notification function mentions self
            // and even in iOS 11, objectB is leaking if the notification function mentions self
            // solution is to use unowned self in the notification function
        case 2:
            // premature deregistration 1
            observer.obs.removeAll()
            observed.value = false
        case 3:
            // premature deregistration 2
            observer.obs.forEach {$0.invalidate()}
            observed.value = false
        case 4:
            // let's artificially keep the observer alive and see what happens
            let obs = observer.obs
            observer = nil
            delay(1) {
                let obs2 = obs // ensure life
                self.observed.value = false
                _ = obs2
            }
            // crash because of the unowned self, as expected
        default:
            // just proving that this would have worked if we had done nothing
            observed.value = false
        }
        
        return true
    }
}
