//
//  UITableView.swift
//
//  Created by Mukesh Yadav on 01/10/18.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewHeaderFooterView>(headerFooterView classType: T.Type) {
        let className = String(describing: T.self).components(separatedBy: ".").last!
        register(UINib(nibName: className), forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for section: Int = 0) -> T? {
        let className = String(describing: T.self).components(separatedBy: ".").last!
        let view = dequeueReusableHeaderFooterView(withIdentifier: className) as? T
        view?.tag = section
        return view
    }
    
    func register<T: UITableViewCell>(cell classType: T.Type) {
        let className = String(describing: T.self).components(separatedBy: ".").last!
        register(UINib(nibName: className), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let className = String(describing: T.self).components(separatedBy: ".").last!
        return dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
}

extension UITableView {
    func setHeaderView(_ headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView = headerView
        
        let centerXConstraint = NSLayoutConstraint(item: headerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: headerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([centerXConstraint, widthConstraint, topConstraint])
        
        tableHeaderView?.layoutIfNeeded()
    }
}