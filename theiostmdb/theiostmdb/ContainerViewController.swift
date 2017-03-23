//
//  ContainerViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
    case RightPanelExpanded
}

class ContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: ViewController!
    var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow: shouldShowShadow)
        }
    }
    var leftViewController: SidePanelViewController?
    
    let centerPanelExpandedOffset: CGFloat = 60
  
  override func viewDidLoad() {
    super.viewDidLoad()
    centerViewController = ViewController()
    centerViewController.delegate = self
    centerNavigationController = UINavigationController(rootViewController: centerViewController)
    view.addSubview(centerNavigationController.view)
    addChildViewController(centerNavigationController)
    
    centerNavigationController.didMove(toParentViewController: self)
  }
  
}

extension ContainerViewController: CenterViewControllerDelegate{
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func toggleRightPanel() {
        
    }
    
    func addLeftPanelViewController(){
        if(leftViewController == nil){
            leftViewController = SidePanelViewController()
            
            addchildSidePanelController(sidePanelController: leftViewController!)
        }
    }
    
    func addchildSidePanelController(sidePanelController: SidePanelViewController){
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func addRightPanelViewController(){
        
    }
    
    func animateLeftPanel(shouldExpand: Bool){
        if(shouldExpand){
            currentState = .LeftPanelExpanded
            animateCenterPanelXPosition(targetPosition: centerNavigationController.view.frame.size.width - centerPanelExpandedOffset)
        }else{
            animateCenterPanelXPosition(targetPosition: 0, completion: {finished in
                self.currentState = .BothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil
            })
        }
        
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    
    func showShadowForCenterViewController(shouldShowShadow: Bool){
        if(shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        }else{
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}

//private extension UIStoryboard {
//  class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
//  
//  class func leftViewController() -> SidePanelViewController? {
//    return mainStoryboard().instantiateViewController(withIdentifier: "LeftViewController") as? SidePanelViewController
//  }
//  
//  class func rightViewController() -> SidePanelViewController? {
//    return mainStoryboard().instantiateViewController(withIdentifier: "RightViewController") as? SidePanelViewController
//  }
//  
//  class func centerViewController() -> CenterViewController? {
//    return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
//  }
//  
//}
