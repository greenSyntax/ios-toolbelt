//
//  UIStoryboard.swift
//
//  Created by Mukesh Yadav on 01/10/18.
//

import UIKit

extension UIStoryboard {
    
    /// Add your storyboards here
    ///
    /// - main: Main storyboard
    enum Name: String {
        case main = "Main"
    }
    
    /**
     Intantiate a view controller form given storyboard case, provided that the storyboard id and the class name is same for that view controller.
     - parameter module: Module name case
     - returns: A view controller instantiated from modules storyobard.
     */
    static func instantiateController<T: UIViewController>(from storyboard: Name = .main) -> T {
        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController()
    }
    
    /**
     Intantiate a view controller form given storyboard case.
     - parameter module: Module name case
     - parameter storyboardId: ViewController storyboard id
     - returns: A view controller instantiated from modules storyobard.
     */
    static func instantiateController<T: UIViewController>(from storyboard: Name,
                                                           with storyboardId: String) -> T {
        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateController(with: storyboardId)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        let name = String(describing: T.self).components(separatedBy: ".").last!
        return instantiateController(with: name)
    }
    
    func instantiateController<T: UIViewController>(with storyboardId: String) -> T {
        return instantiateViewController(withIdentifier: storyboardId)
            as! T
    }
    
    static func viewController<T:UIViewController>(identifer: String) -> T {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifer) as! T
    }
}
