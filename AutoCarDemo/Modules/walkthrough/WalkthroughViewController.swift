//
//  WalkthroughViewController.swift
//  Little Agent
//
//  Created by edwin weru on 17/05/2021.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
            nextButton.backgroundColor = .colorPrimary
        }
    }
    
    @IBOutlet var skipButton: UIButton!
    @IBOutlet weak var btn_cancel: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    //MARK:- variables
    
    var window: UIWindow?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    var goToMain: (() -> Void)?
    var coordinator: WalkthroughCoordinator?
    
    // MARK: - View controller life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Navigation Bar:
        navigationController?.navigationBar.barTintColor = .colorPrimary
        // Navigation Bar Text:
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        // Tab Bar:
        tabBarController?.tabBar.barTintColor = UIColor.colorPrimary
        // Tab Bar Text:
        tabBarController?.tabBar.tintColor = UIColor.colorPrimary
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = UIColor.colorPrimary
        
        //skipButton.addTarget(self, action: #selector(self.doneAction(_:)), for: .touchUpInside)
        //nextButton.addTarget(self, action: #selector(self.doneAction(_:)), for: .touchUpInside)
        
        // add child view controller view to container

        let controller = WalkthroughPageViewController()
        walkthroughPageViewController = controller
        walkthroughPageViewController?.walkthroughDelegate = self
        
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(controller.view)

        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])

        controller.didMove(toParent: self)
    }
    
    // MARK: - Actions
    
    @IBAction func actionCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func skipButtonTapped(sender: UIButton) {
        nextVc()
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...2:
                walkthroughPageViewController?.forwardPage()
                
            case 3:
                
                nextVc()
                
            default: break
            }
        }
        
        updateUI()
    }
    
    private func nextVc() {
        //AppUser.setHasViewedWalkthrough(has_viewed: true)
        self.goToMain?() //createQuickAction() //dismiss(animated: true, completion: nil)
    }
    
    //objc
    @objc func doneAction(_ sender: UIButton) {
        print("button tapped")
        nextVc()
    }
    
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...2:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            
            case 3:
                nextButton.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
                
            default: break
            }
            
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }

    // MARK: - 3D Touch methods
    
    func createQuickAction() {
        // Add Quick Actions
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                let shortcutItem1 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenFavorites", localizedTitle: "Show Favorites", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(templateImageName: "favorite-shortcut"), userInfo: nil)
                
                let shortcutItem2 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenDiscover", localizedTitle: "Discover cafes", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(templateImageName: "discover-shortcut"), userInfo: nil)
                
                let shortcutItem3 = UIApplicationShortcutItem(type: "\(bundleIdentifier).NewCafe", localizedTitle: "New Cafe", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .add), userInfo: nil)
                
                UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
            }
        }
    }
    
}
