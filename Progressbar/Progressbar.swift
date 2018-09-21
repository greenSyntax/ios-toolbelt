//
//  Progressbar.swift
//  admin
//
//  Created by Abhishek  Kumar Ravi on 21/09/18.
//  Copyright © 2018 C Color. All rights reserved.
//

import Foundation

extension UIViewController {
    
    static let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    func showProgressbar() {
        
        UIViewController.activityIndicator.center = self.view.center
        UIViewController.activityIndicator.startAnimating()
        self.view.addSubview(UIViewController.activityIndicator)
    }
    
    func hideProgressbar() {
        UIViewController.activityIndicator.stopAnimating()
        UIViewController.activityIndicator.removeFromSuperview()
    }
    
}
