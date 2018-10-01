import Foundation

extension NSObject {
    
    
    /// Get class name from object.
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    /// Get class name from Type metadata of class.
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
