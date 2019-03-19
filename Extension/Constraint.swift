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
    
    
    /// Add constraint with varargs
    ///
    /// - Parameters:
    ///   - subview: subview to be added
    ///   - constants: constants in following sequence: `leading, top, trailing, bottom, width, height`
    public func addSubview(_ subview: UIView, constants: CGFloat...) {
        addSubview(subview, constraints: [
            equal(\UIView.leadingAnchor, constant: constants[safe: 0] ?? 0),
            equal(\UIView.topAnchor, constant: constants[safe: 1] ?? 0),
            equal(\UIView.trailingAnchor, constant: -(constants[safe: 2] ?? 0)),
            equal(\UIView.bottomAnchor, constant: -(constants[safe: 3] ?? 0))
        ])
        
        if let width = constants[safe: 4] {
            addConstraint(equal(\UIView.widthAnchor, constant: width)(subview, self))
        }
        
        if let height = constants[safe: 5] {
            addConstraint(equal(\UIView.heightAnchor, constant: height)(subview, self))
        }
    }
}

// Example
//addSubview(childView, constraints:[
//    equal(\.centerYAnchor, \.bottomAnchor),
//    equal(\.leadingAnchor, constant: 10), equal(\.trailingAnchor, constant: -10),
//    equal(\.heightAnchor, constant: 100)
//])
