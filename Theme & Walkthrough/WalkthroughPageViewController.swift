//
//  WalkthroughPageViewController.swift
//  ThemeAppSampel
//
//  Created by Abhishek  Kumar Ravi on 11/07/18.
//  Copyright © 2018 Abhishek  Kumar Ravi. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let firstView = orderedViewController.first {
            setViewControllers([firstView], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var orderedViewController: [UIViewController] = {
        return [createView(identifier: "GreenView"), createView(identifier: "BlueView"), createView(identifier: "GrayView")]
    }()
    
    private func createView(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
    }
    
}

extension WalkthroughPageViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let firstView = viewControllers?.first, let firstViewControllerIndex = orderedViewController.index(of: firstView) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewController.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewController.count > previousIndex else {
            return nil
        }
        
        return orderedViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewController.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllerCount = orderedViewController.count
        
        guard orderedViewControllerCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllerCount > nextIndex else {
            return nil
        }
        
        return orderedViewController[nextIndex]
    }
    
}
