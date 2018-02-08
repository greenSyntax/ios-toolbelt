

import Foundation
import UIKit

extension UIStoryboard {
    
    static func viewController<T:UIViewController>(identifer: String) -> T {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifer) as! T
    }
}
