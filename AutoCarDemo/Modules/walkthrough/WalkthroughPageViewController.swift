//
//  WalkthroughPageViewController.swift
//  Little Agent
//
//  Created by edwin weru on 17/05/2021.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Properties
    
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    var pageHeadings = [
        "Great Food",
        "Handled With Care",
        "Ontime Delivery",
        "Enjoy"
    ]
    var pageImages = [
        "ic_food_phone",
        "ic_delivery_bike",
        "ic_delivery_man",
        "ic_steak"
    ]
    
    var pageSubHeadings = [
        "Have your original Kenyan National ID or Passport",
        "A pdf copy of your KRA pin certificate for upload purposes",
        "Take a photo - potrait of yourself(Selfie)",
        "You are requested to do an on screen Signature"
    ]
    
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source and the delegate to itself
        dataSource = self
        delegate = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    // MARK: - Helper
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data
        let pageContentViewController = WalkthroughContentViewController()
            
        pageContentViewController.imageFile = pageImages[index]
        pageContentViewController.heading = pageHeadings[index]
        pageContentViewController.subHeading = pageSubHeadings[index]
        pageContentViewController.index = index
        
        return pageContentViewController
            
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller delegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                currentIndex = contentViewController.index
                
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }

}
