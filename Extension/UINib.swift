//
//  UINib.swift
//
//  Created by Mukesh Yadav on 01/10/18.
//

import UIKit

extension UINib {
    
    static func instantiateWithOwner<T: UIView>(_ owner: AnyObject?) -> T {
        let nibName = String(describing: T.self).components(separatedBy: ".").last!
        return Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?.first as! T
    }
    
    static func instantiateView<T: UIView>() -> T {
        let nibName = String(describing: T.self).components(separatedBy: ".").last!
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! T
    }
}