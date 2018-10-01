//
//  UICollectionView.swift
//
//  Created by Mukesh Yadav on 01/10/18.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cell classType: T.Type) {
        let className = String(describing: T.self).components(separatedBy: ".").last!
        register(UINib(nibName: className), forCellWithReuseIdentifier: className)
    }
    
    func register<T: UICollectionReusableView>(view classType: T.Type, for kind: String) {
        let className = String(describing: T.self).components(separatedBy: ".").last!
        register(UINib(nibName: className), forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let className = String(describing: T.self).components(separatedBy: ".").last!
        return dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! T
    }
    
    func setHeaderView(_ headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerView)
        
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        self.contentInset = UIEdgeInsets(top: height, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
        
        let centerXConstraint = NSLayoutConstraint(item: headerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: headerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: -height)
        
        NSLayoutConstraint.activate([centerXConstraint, widthConstraint, topConstraint])
        
        headerView.layoutIfNeeded()
    }
}
