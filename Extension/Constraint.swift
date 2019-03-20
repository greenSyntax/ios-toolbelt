//
//  Constraint.swift
//  Chefling
//
//  Created by Mukesh on 19/03/19.
//  Copyright © 2019 Chefling Inc. All rights reserved.
//

import Foundation

public typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

public func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        view1[keyPath: from].constraint(equalTo: view2[keyPath: to], constant: constant)
    }
}

public func equal<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return equal(to, to, constant: constant)
}

public func equal<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        view1[keyPath: keyPath].constraint(equalToConstant: constant)
    }
}

extension UIView {
    public func addSubview(_ subview: UIView, constraints: [Constraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addConstraints(constraints.map { $0(subview, self) })
    }
    
    public func addSubview(withParent subview: UIView) {
        addSubview(subview, constraints: [
            equal(\UIView.leadingAnchor),
            equal(\UIView.topAnchor),
            equal(\UIView.trailingAnchor),
            equal(\UIView.bottomAnchor)
        ])
    }
    
    
    public func addSubview(
        _ subview: UIView,
        constants leading: CGFloat? = nil,
        _ top: CGFloat? = nil,
        _ trailing: CGFloat? = nil,
        _ bottom: CGFloat? = nil,
        _ width: CGFloat? = nil,
        _ height: CGFloat? = nil) {
        
        var constraints: [Constraint] = []
        
        if let leading = leading {
            constraints.append(equal(\UIView.leadingAnchor, constant: leading))
        }
        
        if let top = top {
            constraints.append(equal(\UIView.topAnchor, constant: top))
        }
        
        if let trailing = trailing {
            constraints.append(equal(\UIView.trailingAnchor, constant: -trailing))
        }
        
        if let bottom = bottom {
            constraints.append(equal(\UIView.bottomAnchor, constant: -bottom))
        }
        
        if let width = width {
            constraints.append(equal(\UIView.widthAnchor, constant: width))
        }
        
        if let height = height {
            constraints.append(equal(\UIView.heightAnchor, constant: height))
        }
        
        addSubview(subview, constraints: constraints)
    }
}

// Example
//addSubview(childView, constraints:[
//    equal(\.centerYAnchor, \.bottomAnchor),
//    equal(\.leadingAnchor, constant: 10), equal(\.trailingAnchor, constant: -10),
//    equal(\.heightAnchor, constant: 100)
//])
