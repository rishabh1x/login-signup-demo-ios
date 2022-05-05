//
//  ActivityIndicator.swift
//  Basis-Auth-Demo
//
//  Created by rishabh on 04/05/22.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class ActivityIndicator {
    
    class func start(controller: UIViewController, navBarMaxY:CGFloat = 0.0) {
        DispatchQueue.main.async {
            let screenSize = UIScreen.main.bounds.size
            let dimContainer = UIView(frame: CGRect(x: 0, y: navBarMaxY, width: screenSize.width, height: screenSize.height))
            dimContainer.backgroundColor = UIColor.darkGray
            dimContainer.alpha = 0.6
            dimContainer.tag = 131737
            
            let activity = MDCActivityIndicator(frame: CGRect(x: controller.view.frame.width/2 - 50, y: controller.view.frame.height/2 - 50, width: 100, height: 100))
            activity.tintColor = Globals.ColorFactory.indigo
            activity.backgroundColor = UIColor.clear
            
            if let oldContainer = controller.view.viewWithTag(131737) as? MDCActivityIndicator {
                oldContainer.removeFromSuperview()
            }
            
            dimContainer.addSubview(activity)
            controller.view.endEditing(true)
            activity.startAnimating()
            controller.view.addSubview(dimContainer)
        }
    }
    
    class func stop(controller: UIViewController) {
        DispatchQueue.main.async {
            if let oldContainer = controller.view.viewWithTag(131737) {
                oldContainer.removeFromSuperview()
            }
            controller.view.isUserInteractionEnabled = true
        }
    }
    
}
