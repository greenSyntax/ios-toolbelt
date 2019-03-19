//
//  Constraint.swift
//  Mukesh
//
//  Created by Mukesh on 19/03/19.
//  Copyright © 2019 Mukesh. All rights reserved.
//

import Foundation

public typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

public func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        view1[keyPath: from].constraint(equalTo: view2[keyPath: to], constant: constant)
    }
}

public func equals<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
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
}

// Example
//    addSubview(childView, constraints:[
//        equal(\.centerYAnchor, \.bottomAnchor),
//        equal(\.leadingAnchor, constant: 10), equal(\.trailingAnchor, constant: -10),
//        equal(\.heightAnchor, constant: 100)
//    ])
